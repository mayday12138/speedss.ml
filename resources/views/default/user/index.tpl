{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            用户中心
            <small>User Center</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
			<!-- START PROGRESS BARS -->
			<div class="row">
				<div class="col-md-10">
					<button id="getclient" class="btn btn-primary">获取客户端</button>
					<button id="getconfig" class="btn btn-primary">获取配置</button>
					<button id="nodelist" class="btn btn-primary">节点列表</button>
					<button id="trafficrecord" class="btn btn-primary">流量记录</button>
					<button id="changeinfo" class="btn btn-primary">修改资料</button>
					<button id="invitefriend" class="btn btn-primary">邀请好友</button>
                                        <button id="homepage" class="btn btn-primary">主页</button>
				</div>
			</div>

			<div class="row">
            			<div class="col-md-10">
                			<div class="callout callout-warning">
                    				<p>由于大陆外网的不稳定性(国际出口间歇性抽风, 跟服务器本身无关), 建议us3, hk2, jp1, us1根据线路情况切换, <a href="http://fast.com">fast.com</a>可以实时测试线路下载速度</p>
                			</div>
            			</div>
        		</div>

                        <div class="row">
                                <div class="col-md-10">
                                        <div class="callout callout-warning">
                                                <p>新用户先 <a href="/user/getclient">获取客户端</a> <a href="/configclient">配置教程</a></p>
                                        </div>
                                </div>
                        </div>

			<div class="row">
				<div class="col-md-6">
					<div class="box box-primary">
						<div class="box-header">
							<i class="fa fa-bullhorn"></i>

							<h3 class="box-title">公告&FAQ</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body">
                       				 {$msg}
						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->
				</div>
				<!-- /.col (right) -->
			
				<div class="col-md-6">
					<div class="box box-primary">
						<div class="box-header">
				                        <i class="fa fa-bullhorn"></i>
                        				<h3 class="box-title">流量低价促销!</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<!--<p>单次购买: 10元30G流量, 月底不清零</p>-->
							<a href="/intro" class="btn btn-primary">产品介绍</a>
							<a href="/intro#pricing" class="btn btn-primary">价格信息</a>
							<!--<p>包月套餐: 10元50G流量</p>
							<p>一次性购买半年(现仅需60元)可享每月80G大流量</p>
							<p>一次性购买全年(现仅需99元)可享全年使用任意节点不限流量</p>-->
							<p>半年套餐(现仅需60元)可享每月80G流量(6台使用设备)</p>
							<p>一年套餐(现仅需120元)可享每月200G大流量(6台使用设备)</p>
							<p>两年套餐(现仅需199元)可享使用任意节点不限流量 不限设备数量</p>
							<p>购买套餐:  <a class="btn btn-primary" href="/downloads/pay.png">支付宝付款</a> <a class="btn btn-primary" href="/downloads/wechatpay.png">微信付款</a></p>
                            <p>微信群(不定时更新邀请):&nbsp&nbsp;<a href="/downloads/wechat.png">二维码</a></p>
						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->
				</div>
				<!-- /.col (right) -->	
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="box box-primary">
						<div class="box-header">
							<i class="fa  fa-paper-plane"></i>

							<h3 class="box-title">连接信息</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<dl class="dl-horizontal">
								<dt>服务器ip地址</dt>
								<dd><a href="/user/node">节点列表</a></dd>
								<dt>端口</dt>
                            					<dd>{$user->port}</dd>
                            					<dt>密码</dt>
                            					<dd>{$user->passwd}</dd>
                            					<dt>自定义加密方式</dt>
                            					<dd>{$user->method}</dd>
                            					<dt>上次使用</dt>
                            					<dd>{$user->lastSsTime()}</dd>
							</dl>
						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->
				</div>
				<!-- /.col (right) -->

				<div class="col-md-6">
					<div class="box box-primary">
						<div class="box-header">
							<i class="fa fa-exchange"></i>

							<h3 class="box-title">流量使用情况</h3>
						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">
								<div class="col-xs-12">
									<div class="progress progress-striped">
										<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="40"
                                         aria-valuemin="0" aria-valuemax="100"
                                         style="width: {$user->trafficUsagePercent()}%">
                                        <span class="sr-only">Transfer</span>
										</div>
									</div>
                            		</div>
							</div>
							<dl class="dl-horizontal">
                            				<dt>总流量</dt>
                            				<dd>{$user->enableTraffic()}</dd>
                            				<dt>已用流量</dt>
                            				<dd>{$user->usedTraffic()}</dd>
                            				<dt>剩余流量</dt>
                            				<dd>{$user->unusedTraffic()}</dd>
							</dl>
						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->
				</div>
				<!-- /.col (left) -->

            

            
		</div>
	
	<!--另起了一行row, 之前box飘到右边了, 原因未知-->
	<div class="row">
           

		<div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-pencil"></i>

                        <h3 class="box-title">签到获取流量</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <p> 每{$config['checkinTime']}小时可以签到一次。</p>

                        <p>上次签到时间：<code>{$user->lastCheckInTime()}</code></p>
                        {if $user->isAbleToCheckin() }
                            <p id="checkin-btn">
                                <button id="checkin" class="btn btn-success  btn-flat">签到</button>
                            </p>
                        {else}
                            <p><a class="btn btn-success btn-flat disabled" href="#">不能签到</a></p>
                        {/if}
                        <p id="checkin-msg"></p>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->			
       		
		<div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-bullhorn"></i>

                        <h3 class="box-title">客户端下载</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
			<p>Android客户端&nbsp&nbsp<a href="/downloads/com.github.shadowsocks.apk">点击下载</a></p>
			<p>Windows客户端&nbsp&nbsp<a href="/downloads/Shadowsocks-win-2.5.6.zip">点击下载</a></p>
			<p>Mac客户端&nbsp&nbsp<a href="/downloads/ShadowsocksX-2.6.3.dmg">点击下载</a></p>
			<p>iOS用户请在App Store搜索下载"Wingy"&nbsp&nbsp<a href="https://itunes.apple.com/cn/app/wingy-http-s-socks5-proxy-utility/id1178584911?mt=8" target="_blank">点击查看</a></p>
            <p>Wingy国区已下架, 请下载ipa安装包, 用iTunes安装  <a href="/downloads/wingy.ipa">点击下载</a></p>
            <p>Linux用户请参考安装手册进行安装</p>
			<p>安装手册(包含各个平台)&nbsp&nbsp<a href="/downloads/SpeedSS_Installation_Manual.pdf">快速查看</a>&nbsp&nbsp<a href="/downloads/SpeedSS_Installation_Manual.docx">点击下载</a></p>
                        <p>安装手册配套软件包&nbsp&nbsp<a href="/downloads/SpeedSS_Installation_Manual_Package.zip">点击下载</a></p>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

	</div>


        <!-- /.row --><!-- END PROGRESS BARS -->
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        $("#checkin").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",
                success: function (data) {
                    $("#checkin-msg").html(data.msg);
                    $("#checkin-btn").hide();
                },
                error: function (jqXHR) {
                    alert("发生错误：" + jqXHR.status);
                }
            })
        })
    })
</script>


{include file='user/footer.tpl'}
