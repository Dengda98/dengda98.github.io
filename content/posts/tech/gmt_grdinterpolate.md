---
title: "使用GMT的grdinterpolate模块获得地震成像的任意纵切面结果"
date: 2025-03-11T22:54:03+08:00
lastmod: 2025-03-11T22:54:03+08:00
author: "Zhu Dengda"
categories: []
tags: ["GMT"]
keywords: []

description: " " # 文章描述，与搜索优化相关
summary: " " # 文章简单描述，会展示在主页
weight: # 输入1可以顶置文章，用来给文章展示排序，不填就默认按时间排序
slug: ""
draft: false # 是否为草稿
comments: true
showToc: true # 显示目录
TocOpen: true # 自动展开目录
autonumbering: true # 目录自动编号
hidemeta: false # 是否隐藏文章的元信息，如发布日期、作者等
disableShare: true # 底部不显示分享栏
searchHidden: false # 该页面可以被搜索到
showbreadcrumbs: true # 顶部显示当前路径
mermaid: true
cover:
    image: ""
    caption: ""
    alt: ""
    relative: false
---

地震成像结果往往是三维空间（经度、纬度、深度）中的单/多变量文件（Vp, Vs），而gmt中大多数模块都是处理二维网格。为了获得任意纵切面的结果，目前常做的处理是在定义了水平测线后，**不同深度层逐一插值处理**，即逐层使用`grdtrack`模块进行插值，最后拼成一个二维网格。

gmt官网介绍了[`grdinterpolate`](https://docs.generic-mapping-tools.org/6.5/grdinterpolate.html)模块可以进行3D网格插值，但似乎使用没那么广。大概浏览了`grdinterpolate`模块的C代码，最后也是调用了`grdtrack`模块。这里我进行了初步测试后，成功插值得到任意纵切面的2D网格，以下是使用流程：

## 准备3D成像网格文件
假设有一个文本格式的成像结果文件`result.txt`，如下
```
102.0 44.5 0.0 5.4
102.2 44.5 0.0 5.4
102.4 44.5 0.0 5.4
102.6 44.5 0.0 5.4
... ...
```
四列分别表示经度、纬度、深度和速度（数值不代表真实情况，仅做测试）。然后我们使用Python的`netcdf4`库处理得到3D成像网格文件，其中有一些细节要注意：
``` python
import numpy as np
import netCDF4 as nc

# 从文本文件中读入数据
data = np.loadtxt("result.txt")

# 多列数据
longitude = data[:, 0]
latitude = data[:, 1]
depth = data[:, 2]  # 深度层不必等距
velocity = data[:, 3]

# 获得网格坐标值
unique_longitude = np.unique(longitude)
unique_latitude = np.unique(latitude)
unique_depth = np.unique(depth)

# 3D速度网格
# 这里维度的顺序是关键，要以"zyx"的顺序排列才能被gmt正确识别（即从右往左读）
velocity_grid = np.full((len(unique_depth), len(unique_latitude), len(unique_longitude)), np.nan)

# 填充速度网格
# 这里示例使用最笨的方法来填充，实际上如果文本文件中的结果是按顺序的，可以更简单一些，但要小心其排列顺序
for i in range(len(data)):
    lon_idx = np.where(unique_longitude == longitude[i])[0][0]
    lat_idx = np.where(unique_latitude == latitude[i])[0][0]
    depth_idx = np.where(unique_depth == depth[i])[0][0]
    velocity_grid[lon_idx, lat_idx, depth_idx] = velocity[i]

# 创建netcdf4网格文件
with nc.Dataset("result.nc", 'w', format='NETCDF4') as dataset:
    # 空间纬度大小
    dataset.createDimension('lon', len(unique_longitude))
    dataset.createDimension('lat', len(unique_latitude))
    dataset.createDimension('depth', len(unique_depth))
    
    # 空间纬度变量
    lon_var = dataset.createVariable('lon', np.float64, ('lon',))
    lat_var = dataset.createVariable('lat', np.float64, ('lat',))
    depth_var = dataset.createVariable('depth', np.float64, ('depth',))
    velocity_var = dataset.createVariable('velocity', np.float64, ('depth', 'lat', 'lon'))
    
    # Assign data to variables
    lon_var[:] = unique_longitude
    lat_var[:] = unique_latitude
    depth_var[:] = unique_depth
    velocity_var[:, :, :] = velocity_grid
    
    # Add attributes
    lon_var.units = 'degrees_east'
    lat_var.units = 'degrees_north'
    depth_var.units = 'km'

```


## 检查文件
可以使用`ncdump -c result.nc`和`gmt grdinfo result.nc`来查看网格文件的基本信息，例如
``` bash 
$ ncdump -c result.nc 
netcdf result {
dimensions:
        lon = 40 ;
        lat = 28 ;
        depth = 100 ;
variables:
        double lon(lon) ;
                lon:units = "degrees_east" ;
        double lat(lat) ;
                lat:units = "degrees_north" ;
        double depth(depth) ;
                depth:units = "km" ;
        double velocity(depth, lat, lon) ;
data:

 lon = 102, 102.2, 102.4, 102.6, 102.8, 103, 103.2, 103.4, 103.6, 103.8, 104, 
    104.2, 104.4, 104.6, 104.8, 105, 105.2, 105.4, 105.6, 105.8, 106, 106.2, 
    106.4, 106.6, 106.8, 107, 107.2, 107.4, 107.6, 107.8, 108, 108.2, 108.4, 
    108.6, 108.8, 109, 109.2, 109.4, 109.6, 109.8 ;

 lat = 44.5, 44.7, 44.9, 45.1, 45.3, 45.5, 45.7, 45.9, 46.1, 46.3, 46.5, 
    46.7, 46.9, 47.1, 47.3, 47.5, 47.7, 47.9, 48.1, 
    48.3, 48.5, 48.7, 48.9, 
    49.1, 49.3, 49.5, 49.7, 
    49.9 ;

 depth = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 
    19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 
    37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 
    55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 
    73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 
    91, 92, 93, 94, 95, 96, 97, 98, 99 ;
}

```
``` bash
$ gmt grdinfo result.nc 
result.nc: Title: 
result.nc: Command: 
result.nc: Remark: 
result.nc: Pixel node registration used [Geographic grid]
result.nc: Grid file format: nd = GMT netCDF format (64-bit float), CF-1.7
result.nc: x_min: 101.9 x_max: 109.9 x_inc: 0.2 (12 min) name: lon n_columns: 40
result.nc: y_min: 44.4 y_max: 50 y_inc: 0.2 (12 min) name: lat n_rows: 28
result.nc: z_min: 0 z_max: 99 z_inc: 1 name: depth [km] n_levels: 100
result.nc: v_min: 0 v_max: 0 name: velocity
result.nc: scale_factor: 1 add_offset: 0
result.nc: format: netCDF-4 chunk_size: 0,0 shuffle: off deflation_level: 0
result.nc: Default CPT: 
```
其中xyz变量的数值范围能正确对应到期望维度的范围。

## 使用grdinterpolate切片
例如给定测线和深度层范围，即可得到任意纵切面的2D网格：
``` bash
gmt grdinterpolate result.nc -E102.2/45.1/109.2/49.3 -T0/80/0.5 -Gslice.nc
```
若3D网格中存在多个速度变量，使用*filename?varname*的形式即可选择变量：
``` bash
gmt grdinterpolate "result.nc?vp" -E102.2/45.1/109.2/49.3 -T0/80/0.5 -Gslice_vp.nc
gmt grdinterpolate "result.nc?vs" -E102.2/45.1/109.2/49.3 -T0/80/0.5 -Gslice_vs.nc
```
