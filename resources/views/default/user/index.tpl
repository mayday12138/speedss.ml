{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			用户中心
			<a class="btn btn-primary" href="https://download.speedss.xyz/main_page_english_version.png">English</a>
			<small>User Center</small>
		</h1>
	</section>

	<!-- Main content -->
	<section class="content">
		<!-- START PROGRESS BARS -->

		<!--<div class="row">
			<div class="col-md-10">
				<div class="callout callout-warning">
					<p>由于大陆外网的不稳定性(国际出口间歇性抽风, 跟服务器本身无关), 建议us3, hk2, jp1, us1根据线路情况切换,
						<a href="http://fast.com">fast.com</a>可以实时测试线路下载速度</p>
				</div>
			</div>
		</div>-->

		<!--<div class="row">
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
		</div>-->

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

			<div class="col-md-6">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa fa-bullhorn"></i>
						<h3 class="box-title">套餐低价促销!</h3>
						<a href="/intro" class="btn btn-primary">产品介绍</a>
						<!-- <a href="/intro#pricing" class="btn btn-primary">价格信息</a> -->
						<a class="btn btn-primary" href="/user/payment">购买套餐</a>
					</div>
					<!-- /.box-header -->
					<div class="box-body table-responsive no-padding">
						<table class="table table-hover">
							<tr>
								<td></td>
								<td>套餐</td>
								<td>价格</td>
								<td>赠送</td>
								<td>设备数量</td>
								<td>流量限制</td>
								<td>
									<td>
							</tr>
							{foreach $plans as $plan}
							<tr>
								<td></td>
								<td>{$plan->plan_name}</td>
								<td>{$plan->plan_price}</td>
								<td>{$plan->plan_detail}</td>
								<td>{$plan->plan_client}</td>
								<td>{$plan->plan_flow}</td>
								<td>
									<a class="btn btn-primary btn-sm" href="/user/payment/{$plan->id}">提交订单</a>
								</td>
							</tr>
							{/foreach}
						</table>
					</div>
				</div>
			</div>

			<!--<div class="col-md-6">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa  fa-paper-plane"></i>

						<h3 class="box-title">连接信息</h3>
					</div>
					<div class="box-body">
						<dl class="dl-horizontal">
							{foreach $nodes as $key=>$node}
								{if $key == 0}
									<dt>{$node->name}</dt>
									<dd>{$node->address}</dd>
								{else}
									<dt>{$node->name}</dt>
									<dd>{$node->address}</dd>
								{/if}
								{if $key == ($nodes->count()-1)}
									<dt>端口(port)</dt>
									<dd>{$node->port}</dd>
									<dt>用户id(UserID)</dt>
									<dd>{$user->uuid}</dd>
									<dt>alterId</dt>
									<dd>{$node->alter_id}</dd>
									<dt>security</dt>
									<dd>{$node->security}</dd>
									<dt>网络类型(network)</dt>
									<dd>{$node->network}</dd>
									<dt>websocket path</dt>
									<dd>{$node->path}</dd>
									<dt>tls</dt>
									<dd>{$node->getTlsAlias()}</dd>
								{/if}
							{/foreach}
						</dl>
					</div>
				</div>
			</div>-->
		</div>

		<!--另起了一行row, 之前box飘到右边了, 原因未知-->
		<div class="row">
			<div class="col-md-12" id="getclientclick">
				<div class="box box-primary">
					<div class="box-header">
						<i class="fa fa-bullhorn"></i>

						<h3 class="box-title">客户端下载</h3>
						<a class="btn btn-primary" href="https://download.speedss.xyz/client_download_english_version.png">English</a>
					</div>
					<div class="box-body table-responsive no-padding">
						<table class="table table-hover">
							<tr>
								<td>
									<p>Android版&nbsp&nbsp
										<a class="btn btn-primary" href="https://download.speedss.xyz/v2rayNG_new.apk">点击下载</a>
									</p>
									<p>安装后打开点击app左上角滑出菜单->订阅设置->点击右上角+号->填写备注(speedss),<br>地址为下方的订阅地址->右上角保存->返回主界面->点击右上角三个点->更新订阅-><br>正常情况下出现服务器列表->右下角绿色图标开启服务</p>
									<p>进一步优化:点击app左上角滑出菜单->设置->路由->绕过局域网及大陆地址->返回主界面重新连接</p>
									<p>旧版通过包(默认全局,支持x86)&nbsp&nbsp<a href="https://download.speedss.xyz/v2rayNG_universal.apk">点击下载</a></p>
									<p>订阅地址 <button id="android_copy_button" class="btn btn-primary" data-clipboard-action="copy" data-clipboard-target="#android_link">点我复制</button> <code id="android_link">https://speedss.xyz/link/{$user->uuid}</code></p>
								</td>
							</tr>
							<tr>
								<td>
									<p>Windows客户端&nbsp&nbsp
										<a class="btn btn-primary" href="/user/getwinzip">点击下载</a>
									</p>
									<p>下载后解压整个目录到桌面, 然后打开v2rayN.exe即可<br>（如果报毒请选择信任，关闭其他代理软件，确保运行正常）</p>
									<p>如果打开提示"请先安装.NET Framework", 先下载安装.net框架 <a href="https://download.speedss.xyz/dotNET_framework_4.6.2.exe">点我下载</a></p>
									<p>如有问题，可以远程协助，<a href="https://doc.speedss.xyz/%E8%BF%9C%E7%A8%8B%E5%8D%8F%E5%8A%A9%E6%B5%81%E7%A8%8B">协助流程</a></p>
								</td>
							</tr>
							<tr>
								<td>
									<p>Mac客户端&nbsp&nbsp&nbsp&nbsp
										<a class="btn btn-primary" href="https://download.speedss.xyz/V2RayX.app.zip">点击下载</a>
									</p>
									<p>新增透明代理模式(所有app走代理)</p>
									<p>下载后解压打开V2RayX.app, 然后输入订阅地址获取配置 (也可以在右上角app图标-服务器订阅处输入)</p>
									<p>如果提示身份不明的开发者, 需要到系统偏好设置->安全性与隐私->允许从以下位置下载的应用->仍要打开</p>
									<p>旧版(不支持透明代理)&nbsp&nbsp<a href="https://download.speedss.xyz/V2RayX.app.zip_old1">点击下载</a></p>
									<p>订阅地址 <button id="android_copy_button" class="btn btn-primary" data-clipboard-action="copy" data-clipboard-target="#android_link">点我复制</button> <code id="android_link">https://speedss.xyz/link/{$user->uuid}</code></p>

								</td>
							</tr>
							<tr>
								<td>
									<p>Linux客户端&nbsp&nbsp
										<a class="btn btn-primary" href="https://download.speedss.xyz/v2ray_2.42_linux_32_new.zip">点击下载</a>
									</p>
									<p>下载后需手动填写配置信息
										<a href="https://doc.speedss.xyz/temp">配置教程</a>（注意使用本网页上方的连接信息，教程的仅供参考）</p>
								</td>
							</tr>
							<tr>
								<td>
									<p>iOS客户端&nbsp&nbsp&nbsp&nbsp&nbsp
										<a class="btn btn-primary" href="https://itunes.apple.com/us/app/shadowrocket/id932747118?mt=8" target="_blank">点击查看</a>
									</p>
									<p>iOS用户需要使用美区帐号在App Store搜索下载"Shadowrocket"(需要付费，2.99美刀)</p>
									<p style="color:red">注意是Shadowrocket 不是shadowRocket 国内苹果账号搜到的是假的</p>
									<p>也可以找管理员索要已经付费过的美区苹果帐号免费下载（登录后在App Store->更新->已购买里面）</p>
									<p>打开Shadowrocket软件后，点击右上角+号，添加类型为Subscribe，URL填写用户中心-iOS客户端<br>下载的订阅地址, 然后点击完成, 提示更新中, 顺利拉到服务器列表后点击未连接即可正确连接服务器</p>
									<p>订阅地址 <button id="ios_copy_button" class="btn btn-primary" data-clipboard-action="copy" data-clipboard-target="#ios_link">点我复制</button> <code id="ios_link">https://speedss.xyz/link/{$user->uuid}</code></p>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>

		<!--<div class="row">
			{foreach $nodes as $key=>$node}
				<div class="col-xs-8 col-md-3">
					<p>iOS {$node->name}</p>
					<div id="v2ray-qr-{$key}-ios">
					</div>
				</div>
			{/foreach}
		</div>
		<div class="row">
			{foreach $nodes as $key=>$node}
				<div class="col-xs-8 col-md-3">
					<p>Android {$node->name}</p>
					<div id="v2ray-qr-{$key}-android">
					</div>
				</div>
			{/foreach}
		</div>-->


		<!-- /.row -->
		<!-- END PROGRESS BARS -->
		<script src=" /assets/public/js/jquery.qrcode.min.js"></script>
		<script src="/assets/public/js/client.min.js"></script>
		<script>
			{foreach $v2ray_qr_android_array as $key=>$qr}
				jQuery('#v2ray-qr-{$key}-android').qrcode({
					"text": "{$qr}"
				});
			{/foreach}
			{foreach $v2ray_qr_ios_array as $key=>$qr}
				jQuery('#v2ray-qr-{$key}-ios').qrcode({
					"text": "{$qr}"
				});
			{/foreach}
		</script>
		<script src="/assets/public/js/clipboard.min.js"></script>
		<script>
			var ios_clipboard = new ClipboardJS('#ios_copy_button');
			ios_clipboard.on('success', function(e) {
				alert("复制成功");
			});
			ios_clipboard.on('error', function(e) {
				console.log(e);
			});
			var android_clipboard = new ClipboardJS('#android_copy_button');
			android_clipboard.on('success', function(e) {
				alert("复制成功");
			});
			android_clipboard.on('error', function(e) {
				console.log(e);
			});
		</script>
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<div class="fixed-btn">
	<img src="refer.png" width="100%" height="100%">
</div>

<script>
	$(document).ready(function () {
		// Create a new ClientJS object
		var client = new ClientJS();
		$.ajax({
			type: "POST",
			url: "/user/fingerprint",
			dataType: "json",
			data: {
				fingerprint: String(client.getFingerprint()),
				system: client.getBrowserData().os.name + " " + client.getBrowserData().os.version,
				browser: client.getBrowserData().browser.name + " " + client.getBrowserData().browser.version
			},
			success: function (data) {
				
			},
			error: function (jqXHR) {
	
			}
		});
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