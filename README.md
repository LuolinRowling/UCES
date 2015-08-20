# UCES
辅导员考核网站 University Counsellor Examination System

## 项目介绍

- 平台辅助老师进行辅导员考核，提供按条件查询学生信息、滚动学生照片抽取考查学生并异步更新页面显示其信息等功能
- 采用J2EE架构（JSP + Servlet + JDBC），系统部署在Tomcat上

## 前端介绍

<p align="center">
<img src="http://i.imgur.com/TZgqSi0.png"/>
<div align="center">
Fig. 进入页（首页）
</div>
</p>

 - 由于界面包含学校信息及较多个人信息，故在这里不展示前端其他界面。
 - Ajax+json 实现学生信息查询及异步显示
 - js 中借助计时器图片的滚动、暂停滚动及随机抽取显示

## 后台介绍

- 由 Servlet 处理表单提交、页面导航、已封装数据库操作函数的调用、json字符串的封装等
- 通过 JDBC 访问和操作 MySQL 数据库
- 使用 DAO 设计模式来封装数据库持久层的操作