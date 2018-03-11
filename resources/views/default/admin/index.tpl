{include file='admin/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            管理中心
            <small>Admin Control</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- START PROGRESS BARS -->
        <div class="row">

            <div class="col-lg-3 col-xs-4">
                <div class="small-box bg-yellow">
                    <div class="inner">
                        <h3>{$sts->getTotalUser()}</h3>

                        <p>总用户</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-person"></i>
                    </div>
                    <a href="/admin/user" class="small-box-footer"> 用户管理
                        <i class="fa fa-arrow-circle-right"></i>
                    </a>
                </div>
            </div>
            <div class="col-lg-3 col-xs-4">
                <div class="small-box bg-yellow">
                    <div class="inner">
                        <h3>{$sts->getPendingOrders()}</h3>

                        <p>未处理订单</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-ios-cart"></i>
                    </div>
                    <a href="/admin/order" class="small-box-footer"> 订单管理
                        <i class="fa fa-arrow-circle-right"></i>
                    </a>
                </div>
            </div>
        </div>
        <!-- /.row -->
        <!-- END PROGRESS BARS -->
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->


{include file='admin/footer.tpl'}