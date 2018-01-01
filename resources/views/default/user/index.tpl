{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			用户中心
			<a class="btn btn-primary" href="https://download.speedss.ml/main_page_english_version.png">English Language</a>			
			<small>User Center</small>
		</h1>
	</section>

	<!-- Main content -->
	<section class="content">
		<!-- START PROGRESS BARS -->
		<!-- <div class="row">
			<div class="col-md-10">
				<button id="getclient" class="btn btn-primary">获取客户端</button>
				<button id="getconfig" class="btn btn-primary">获取配置</button>
				<button id="nodelist" class="btn btn-primary">节点列表</button>
				<button id="trafficrecord" class="btn btn-primary">流量记录</button>
				<button id="changeinfo" class="btn btn-primary">修改资料</button>
				<button id="invitefriend" class="btn btn-primary">邀请好友</button>
				<button id="homepage" class="btn btn-primary">主页</button>
			</div>
		</div> -->

		<!--<div class="row">
			<div class="col-md-10">
				<div class="callout callout-warning">
					<p>由于大陆外网的不稳定性(国际出口间歇性抽风, 跟服务器本身无关), 建议us3, hk2, jp1, us1根据线路情况切换,
						<a href="http://fast.com">fast.com</a>可以实时测试线路下载速度</p>
				</div>
			</div>
		</div>-->

		<div class="row">
			<div class="col-md-10">
				<div class="callout callout-warning">
					<p>新用户先下载客户端&nbsp&nbsp
						<a onclick="javascript:document.getElementById('getclientclick').scrollIntoView()"> 客户端下载及配置教程</a>
					</p>
					<div class="table-responsive no-padding">
						<table class="table table-condensed">
							{foreach $userInfos as $userInfo}
							<tr>
								<td>{date('Y-m-d', strtotime($userInfo->created_at))}</td>
								<td>{$userInfo->content}</td>
							</tr>
							{/foreach}
						</table>
					</div>
					<dl class="dl-horizontal">
						<dt>套餐类型</dt>
						<dd>{$user->payment_name}</dd>
						<dt>套餐有效期至</dt>
						<dd>{$user->paymentDate()}</dd>
						<dt>套餐状态</dt>
						<dd>{$user->payment_status}</dd>
						<dt>用户id</dt>
						<dd>{$user->uuid}</dd>
					</dl>
				</div>
			</div>
		</div>

		<div class="row">
			<!--<div class="col-md-6">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa fa-bullhorn"></i>

						<h3 class="box-title">公告&FAQ</h3>
					</div>
					<div class="box-body table-responsive no-padding">
						<table class="table table-hover">
							{foreach $userInfos as $userInfo}
							<tr>
								<td>{date('Y-m-d', strtotime($userInfo->created_at))}</td>
								<td>{$userInfo->content}</td>
							</tr>
							{/foreach}
						</table>
					</div>
				</div>
			</div>-->

			<div class="col-md-6">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa  fa-paper-plane"></i>

						<h3 class="box-title">连接信息</h3>
					</div>
					<div class="box-body">
						<dl class="dl-horizontal">
							<dt>服务器地址(address)</dt>
							<dd>{$v2ray_node_1->address}</dd>
							<dt>备用服务器地址</dt>
							<dd>{$v2ray_node_2->address}</dd>
							<dt>端口(port)</dt>
							<dd>{$v2ray_node_1->port}</dd>
							<dt>用户id(UserID)</dt>
							<dd>{$user->uuid}</dd>
							<dt>alterId</dt>
							<dd>{$v2ray_node_1->alter_id}</dd>
							<dt>security</dt>
							<dd>{$v2ray_node_1->security}</dd>
							<dt>网络类型(network)</dt>
							<dd>{$v2ray_node_1->network}</dd>
							<dt>websocket path</dt>
							<dd>{$v2ray_node_1->path}</dd>
							<dt>tls</dt>
							<dd>{$v2ray_node_1->getTlsAlias()}</dd>

						</dl>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa fa-bullhorn"></i>
						<h3 class="box-title">套餐低价促销!</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<!--<p>单次购买: 10元30G流量, 月底不清零</p>-->
						<a href="/intro" class="btn btn-primary">产品介绍</a>
						<a href="/intro#pricing" class="btn btn-primary">价格信息</a>

						<!--<p>包月套餐: 10元50G流量</p>
							<p>一次性购买半年(现仅需60元)可享每月80G大流量</p>
							<p>一次性购买全年(现仅需99元)可享全年使用任意节点不限流量</p>-->
						<p>半年套餐(现仅需60元)每月80G流量(6台使用设备)</p>
						<p>一年套餐(现仅需120元)每月200G大流量(6台使用设备)</p>
						<p>两年套餐(现仅需199元)使用任意节点不限流量 不限设备数量</p>
						<p>购买套餐:
							<!--<a class="btn btn-primary" href="/downloads/pay.png">支付宝付款</a>-->
							<!--<a class="btn btn-primary" href="/downloads/wechatpay.png">微信付款</a>-->
							<a class="btn btn-primary" href="/user/payment">购买套餐</a>
						</p>
						<p>&nbsp</p>
						<!--<p>微信群(不定时更新邀请):&nbsp&nbsp;
							<a href="/downloads/wechat.png">二维码</a>
						</p>-->
					</div>
				</div>
			</div>
		</div>

		<!--<div class="row">
			<div class="col-md-6">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa  fa-paper-plane"></i>

						<h3 class="box-title">连接信息</h3>
					</div>
					<div class="box-body">
						<dl class="dl-horizontal">
							<dt>服务器地址(address)</dt>
							<dd>{$v2ray_node_1->address}</dd>
							<dt>备用服务器地址</dt>
							<dd>{$v2ray_node_2->address}</dd>
							<dt>端口(port)</dt>
							<dd>{$v2ray_node_1->port}</dd>
							<dt>用户id(UserID)</dt>
							<dd>{$user->uuid}</dd>
							<dt>alterId</dt>
							<dd>{$v2ray_node_1->alter_id}</dd>
							<dt>security</dt>
							<dd>{$v2ray_node_1->security}</dd>
							<dt>网络类型(network)</dt>
							<dd>{$v2ray_node_1->network}</dd>
							<dt>websocket path</dt>
							<dd>{$v2ray_node_1->path}</dd>
							<dt>tls</dt>
							<dd>{$v2ray_node_1->getTlsAlias()}</dd>

						</dl>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa fa-exchange"></i>

						<h3 class="box-title">套餐信息</h3>
					</div>
					<div class="box-body">
						<dl class="dl-horizontal">
							<dt>套餐类型</dt>
							<dd>{$user->payment_name}</dd>
							<dt>套餐有效期至</dt>
							<dd>{$user->paymentDate()}</dd>
							<dt>套餐状态</dt>
							<dd>{$user->payment_status}</dd>
						</dl>
					</div>
				</div>
			</div>
		</div>-->



		<!--另起了一行row, 之前box飘到右边了, 原因未知-->
		<div class="row">


			<!--<div class="col-md-6">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa fa-pencil"></i>

						<h3 class="box-title">签到获取流量</h3>
					</div>
					<div class="box-body">
						<p> 每{$config['checkinTime']}小时可以签到一次。</p>

						<p>上次签到时间：
							<code>{$user->lastCheckInTime()}</code>
						</p>
						{if $user->isAbleToCheckin() }
						<p id="checkin-btn">
							<button id="checkin" class="btn btn-success  btn-flat">签到</button>
						</p>
						{else}
						<p>
							<a class="btn btn-success btn-flat disabled" href="#">不能签到</a>
						</p>
						{/if}
						<p id="checkin-msg"></p>
					</div>
				</div>
			</div>-->

			<div class="col-md-12" id="getclientclick">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa fa-bullhorn"></i>

						<h3 class="box-title">客户端下载</h3>
						<a class="btn btn-primary" href="https://download.speedss.ml/client_download_english_version.png">English Language</a>
					</div>
					<div class="box-body table-responsive no-padding">
						<table class="table table-hover">
							<tr>
								<td>
									<p>Android客户端&nbsp&nbsp
										<a class="btn btn-primary" href="https://download.speedss.ml/v2rayNG.apk">点击下载</a>
										<a class="btn btn-primary" href="https://doc.speedss.ml/diagnostics/">连接不上排查步骤</a>
									</p>
									<!-- <p>先下载客户端，打开后点击右上角加号->import config from QRcode 扫描下方android二维码导入配置，点击成功后再点击右下角飞机图标开启服务</p> -->
									<p>安装后登录网站帐号，然后同意vpn连接即可</p>
								</td>
							</tr>
							<tr>
								<td>
									<p>Windows客户端&nbsp&nbsp
										<a class="btn btn-primary" href="/user/getwinzip">点击下载</a>
										<a class="btn btn-primary" href="https://doc.speedss.ml/diagnostics/">连接不上排查步骤</a>
										<a class="btn btn-primary" href="https://doc.speedss.ml/%E8%BF%9C%E7%A8%8B%E5%8D%8F%E5%8A%A9%E6%B5%81%E7%A8%8B">远程协助</a>
									</p>
									<p>下载后解包打开v2rayN.exe即可（如果报毒选择信任，关闭其他代理软件，确保运行正常）如有问题，可以远程协助，
										<a href="https://doc.speedss.ml/%E8%BF%9C%E7%A8%8B%E5%8D%8F%E5%8A%A9%E6%B5%81%E7%A8%8B">协助流程</a>
									</p>
								</td>
							</tr>
							<tr>
								<td>
									<p>Mac客户端&nbsp&nbsp
										<a class="btn btn-primary" href="https://download.speedss.ml/V2RayX.app.zip">点击下载</a>
										<a class="btn btn-primary" href="https://doc.speedss.ml/diagnostics/">连接不上排查步骤</a>
										<a class="btn btn-primary" href="https://doc.speedss.ml/%E8%BF%9C%E7%A8%8B%E5%8D%8F%E5%8A%A9%E6%B5%81%E7%A8%8B">远程协助</a>
									</p>
									<p>下载后需手动填写配置信息
										<a href="https://doc.speedss.ml/temp">配置教程</a>（注意使用本网页上方的连接信息，教程的仅供参考）</p>
								</td>
							</tr>
							<tr>
								<td>
									<p>iOS客户端&nbsp&nbsp
										<a class="btn btn-primary" href="https://itunes.apple.com/cn/app/shadowray/id1283082051?mt=8" target="_blank">点击查看</a>
										<a class="btn btn-primary" href="/user/watchvideo">查看操作视频</a>
									</p>
									<p>iOS用户请在App Store搜索下载"shadowray"(需要付费，12元)</p>
									<p>也可以找管理员索要已经付费过的苹果帐号免费下载（登录后在App Store->更新->已购买里面）</p>
									<p>进入后点击no server->scan QR Code 然后扫描下方iOS二维码导入配置，返回点击火箭图标，变为鲜绿色为连接成功</p>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row" id="qrcodebar">
			<div class="col-xs-8 col-md-3">
				<p>Android 主服务器</p>
				<div id="v2ray-qr-1-android">

				</div>
			</div>
			<div class="col-xs-8 col-md-3">
				<p>Android 备用服务器</p>
				<div id="v2ray-qr-2-android">

				</div>
			</div>
			<div class="col-xs-8 col-md-3">
				<p>iOS 主服务器</p>
				<div id="v2ray-qr-1-ios">

				</div>
			</div>
			<div class="col-xs-8 col-md-3">
				<p>iOS 备用服务器</p>
				<div id="v2ray-qr-2-ios">

				</div>
			</div>
		</div>


		<!-- /.row -->
		<!-- END PROGRESS BARS -->
		<script src=" /assets/public/js/jquery.qrcode.min.js "></script>
		<script>
			jQuery('#v2ray-qr-1-android').qrcode({
				"text": "{$v2ray_qr_1_android}"
			});
			jQuery('#v2ray-qr-2-android').qrcode({
				"text": "{$v2ray_qr_2_android}"
			});
			jQuery('#v2ray-qr-1-ios').qrcode({
				"text": "{$v2ray_qr_1_ios}"
			});
			jQuery('#v2ray-qr-2-ios').qrcode({
				"text": "{$v2ray_qr_2_ios}"
			});
		</script>
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->

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
</script> {include file='user/footer.tpl'}