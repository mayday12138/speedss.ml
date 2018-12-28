<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>{$config["appName"]}</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="/assets/public/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="/assets/public/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Ionicons -->
    <link href="/assets/public/css/ionicons.min.css" rel="stylesheet">
    <!-- Theme style -->
    <link href="/assets/public/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link href="/assets/public/css/skins/skin-alague.css" rel="stylesheet" type="text/css" />

    <link href="/assets/public/css/custom.css" rel="stylesheet" type="text/css" />

    <!-- jQuery 2.1.3 -->
    <script src="/assets/public/js/jquery.min.js"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="//cdn.bootcss.com/html5shiv/3.7.0/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>

<body class="skin-alague">
    <div class="visible-xs" style="z-index:1100;position:fixed;left:50%;margin-left: -115px;width: 230px;height: 50px;">
        <p onclick="goToHome()" style="font-size:20px;line-height:50px;text-align:center;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-weight:300;color:#4b4b4b; background-color:#fff;">{$config["appName"]}</p>
    </div>
    <script>
        function goToHome() {
            location.href = "/user";
        }
    </script>
    <!-- Site wrapper -->
    <div class="wrapper">

        <header class="main-header">
            <a href="/user" class="logo hidden-xs">{$config["appName"]}</a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>

                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <img src="{$user->gravatar}" class="user-image" alt="User Image" />
                                <span class="hidden-xs">{$user->user_name}</span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- User image -->
                                <li class="user-header">
                                    <img src="{$user->gravatar}" class="img-circle" alt="User Image" />

                                    <p>
                                        {$user->email}
                                        <small>加入时间：{$user->regDate()}</small>
                                    </p>
                                </li>
                                <li class="user-footer">
                                    <div class="pull-left">
                                        <a href="/user/profile" class="btn btn-default btn-flat">个人信息</a>
                                    </div>
                                    <div class="pull-right">
                                        <a href="/user/logout" class="btn btn-default btn-flat">退出</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>

        <!-- =============================================== -->

        <!-- Left side column. contains the sidebar -->
        <aside class="main-sidebar">
            <!-- sidebar: style can be found in sidebar.less -->
            <section class="sidebar">
                <!-- Sidebar user panel -->
                <div class="user-panel">
                    <div class="pull-left image">
                        <img src="{$user->gravatar}" class="img-circle" alt="User Image" />
                    </div>
                    <div class="pull-left info">
                        <p>{$user->user_name}</p>

                        <a href="#">
                            <i class="fa fa-circle text-success"></i> Online</a>
                    </div>
                </div>

                <!-- sidebar menu: : style can be found in sidebar.less -->
                <ul class="sidebar-menu">
                    <li>
                        <a href="/user">
                            <i class="fa fa-dashboard"></i>
                            <span>用户中心</span>
                        </a>
                    </li>

                    <li>
                        <a href="/user/payment">
                            <i class="fa fa-bullhorn"></i>
                            <span>购买套餐</span>
                        </a>
                    </li>

                    <li>
                        <a href="/user/invite">
                            <i class="fa fa-users"></i>
                            <span>邀请好友 (30%返利)</span>
                        </a>
                    </li>

                    <!--<li>
                    <a href="/user/node">
                        <i class="fa fa-sitemap"></i> <span>节点列表</span>
                    </a>
                </li>-->

                    <!--<li>
                    <a href="/user/getclient">
                        <i class="glyphicon glyphicon-download-alt"></i> <span>客户端</span>
                    </a>
                </li>-->

                    <!-- <li>
                        <a href="https://doc.speedss.xyz">
                            <i class="fa fa-file-text-o"></i>
                            <span>文档中心</span>
                        </a>
                    </li> -->

                    <!-- <li>
                        <a href="https://doc.speedss.xyz/temp">
                            <i class="fa fa-file-text-o"></i>
                            <span>配置教程</span>
                        </a>
                    </li> -->

                    <li>
                        <a href="https://doc.speedss.xyz/远程协助流程">
                            <i class="fa fa-users"></i>
                            <span>远程协助</span>
                        </a>
                    </li>
                    <li>
                        <a href="/user/ticket">
                            <i class="fa fa-users"></i>
                            <span>提交工单</span>
                        </a>
                    </li>
                    <!--<li>
                    <a href="/user/profile">
                        <i class="fa fa-user"></i> <span>我的信息</span>
                    </a>
                </li>-->

                    <!--<li>
                    <a href="/user/trafficlog">
                        <i class="fa fa-history"></i> <span>流量记录</span>
                    </a>
                </li>-->


                    <li>
                        <a href="/user/edit">
                            <i class="fa  fa-pencil"></i>
                            <span>修改资料</span>
                        </a>
                    </li>

                    {if $user->isAdmin()}
                    <li>
                        <a href="/admin">
                            <i class="fa fa-cog"></i>
                            <span>管理面板</span>
                        </a>
                    </li>
                    {/if}

                </ul>
            </section>
            <!-- /.sidebar -->
        </aside>