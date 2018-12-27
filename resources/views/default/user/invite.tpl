{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <!--<section class="content-header">
        <h1>
            邀请
            <small>Invite</small>
        </h1>
    </section>-->

    <!-- Main content -->
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-sm-12">
                <div id="msg-error" class="alert alert-warning alert-dismissable" style="display:none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4>
                        <i class="icon fa fa-warning"></i> 出错了!</h4>

                    <p id="msg-error-p"></p>
                </div>
            </div>
        </div>

        <!--<div class="row">
            <div class="col-md-6">
                <div class="callout callout-warning">
                    <p>邀请有记录, 虚假邀请会面临封号</p>
                </div>
            </div>
        </div>-->


        <div class="row">
            <!-- left column -->
            <div class="col-md-8">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-rocket"></i>

                        <h3 class="box-title">邀请</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="input-group">
                            <div class="input-group-btn">
                                <button id="shareurl_button" type="button" class="btn btn-info" data-clipboard-action="copy" data-clipboard-target="#shareurl">复制邀请链接</button>
                            </div>
                            <!-- /btn-group -->
                            <input id="shareurl" type="text" class="form-control" value="{$shareurl}">
                        </div>
                        <div class="nav-tabs-custom" style="margin-top:10px">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#tab_1" data-toggle="tab">我的邀请用户</a></li>
                                <li><a href="#tab_2" data-toggle="tab">购买返利记录</a></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab_1">
                                    <div class="box-header">
                                        <h3 class="box-title">我的邀请用户</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="table-responsive">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>昵称</th>
                                                    <th>用户邮箱</th>
                                                    <th>状态</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach $users as $user}
                                                <tr>
                                                    <td>
                                                        <b>{$user->user_name}</b>
                                                    </td>
                                                    <td>
                                                        <b>{$user->email}</b>
                                                    </td>
                                                    <td>
                                                        <b>{$user->payment_name}</b>
                                                    </td>
                                                </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- /.tab-pane -->
                                <div class="tab-pane" id="tab_2">
                                    <div class="box-header">
                                        <h3 class="box-title">购买返利记录</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="table-responsive">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th>返利</th>
                                                    <th>昵称</th>
                                                    <th>用户邮箱</th>
                                                    <th>套餐</th>
                                                    <th>状态</th>
                                                    <th>时间</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach $orders as $order}
                                                <tr>
                                                    <td>
                                                        {if $order->payment_name == "季度套餐" && $order->order_status == "已完成"}
                                                        <b>返利一个月时长已到账</b> {else if $order->payment_name == "半年套餐" && $order->order_status
                                                        == "已完成"}
                                                        <b>返利两个月时长已到账</b> {else if $order->payment_name == "一年套餐" && $order->order_status
                                                        == "已完成"}
                                                        <b>返利四个月时长已到账</b> {else}
                                                        <b>未到账</b> {/if}
                                                    </td>
                                                    <td>
                                                        <b>{$order->user_name}</b>
                                                    </td>
                                                    <td>
                                                        <b>{$order->user_email}</b>
                                                    </td>
                                                    <td>
                                                        <b>{$order->payment_name}</b>
                                                    </td>
                                                    <td>
                                                        <b>{$order->order_status}</b>
                                                    </td>
                                                    <td>
                                                        <b>{$order->created_time}</b>
                                                    </td>
                                                </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- /.tab-pane -->
                            </div>
                            <!-- /.tab-content -->
                        </div>
                    </div>
                    <!-- /.box -->
                </div>
            </div>
            <div class="col-md-4">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-rocket"></i>

                        <h3 class="box-title">邀请返利30%时长</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <img src="/refer.png" width="100%" height="100%">
                        <ul style="margin-top:10px">
                            <li>邀请人使用你的邀请链接注册</li>
                            <li>或者注册时填写你的邮箱作为邀请人邮箱</li>
                            <li>均视为有效状态</li>
                            <li>被邀请人每笔订单均会返利30%时长</li>
                            <li>可在邀请好友-购买返利记录查看</li>
                        </ul>
                    </div>
                    <!-- /.box -->
                </div>
            </div>
        </div>
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<script src="/assets/public/js/clipboard.min.js"></script>
<script>
    var shareurl = new ClipboardJS('#shareurl_button');
    shareurl.on('success', function (e) {
        alert("复制成功");
    });
    shareurl.on('error', function (e) {
        console.log(e);
    });
</script>

<script>
    $(document).ready(function () {
        $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/invite",
                dataType: "json",
                success: function (data) {
                    window.location.reload();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })

</script> {include file='user/footer.tpl'}