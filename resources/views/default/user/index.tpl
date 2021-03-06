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
		<div class="row">
			<div class="col-md-12 visible-xs">
				<div class="box box-primary">
					<a href="/user/invite"><img src="refer.png" style="width:100%;height:auto;border-radius: 3px;"></a>
				</div>
			</div>
		</div>
		<div class="row">
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
					<b>&nbsp&nbsp&nbsp&nbsp套餐类型&nbsp&nbsp&nbsp&nbsp{$user->payment_name}</b><br>
					<b>&nbsp&nbsp&nbsp&nbsp有效期至&nbsp&nbsp&nbsp&nbsp{$user->paymentDate()}</b><br>
					<b>&nbsp&nbsp&nbsp&nbsp套餐状态&nbsp&nbsp&nbsp&nbsp{$user->payment_status}</b>
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
						<div class="nav-tabs-custom">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#tab_1" data-toggle="tab" aria-expanded="true">Android</a></li>
								<li class=""><a href="#tab_2" data-toggle="tab" aria-expanded="false">iOS</a></li>
								<li class=""><a href="#tab_3" data-toggle="tab" aria-expanded="false">Windows</a></li>
								<li class=""><a href="#tab_4" data-toggle="tab" aria-expanded="false">Mac</a></li>
								<li class=""><a href="#tab_5" data-toggle="tab" aria-expanded="false">Linux</a></li>

							</ul>
							<div class="tab-content col-md-8">
								<div class="tab-pane active" id="tab_1">
									<p>Android版&nbsp
										<a class="btn btn-primary" href="https://download.speedss.xyz/v2rayNG_new.apk">点击下载</a>
									</p>
									<p>安装后打开点击app左上角滑出菜单->订阅设置->点击右上角+号->填写备注(speedss),地址为下方的订阅地址->右上角保存->返回主界面->点击右上角三个点->更新订阅->正常情况下出现服务器列表->右下角绿色图标开启服务</p>
									<p>进一步优化:点击app左上角滑出菜单->设置->路由->绕过局域网及大陆地址->返回主界面重新连接</p>
									<p>旧版通过包(默认全局,支持x86)&nbsp&nbsp<a href="https://download.speedss.xyz/v2rayNG_universal.apk">点击下载</a></p>
									<div class="input-group">
										<div class="input-group-btn">
											<button id="android_copy_button" type="button" class="btn btn-info" data-clipboard-action="copy" data-clipboard-target="#android_link">复制订阅地址</button>
										</div>
										<!-- /btn-group -->
										<input id="android_link" type="text" class="form-control" value="https://speedss.xyz/link/{$user->uuid}">
									</div>
								</div>
								<div class="tab-pane" id="tab_2">
									<p>iOS客户端&nbsp&nbsp
										<a class="btn btn-primary" href="https://itunes.apple.com/us/app/shadowrocket/id932747118?mt=8" target="_blank">点击查看</a>
									</p>
									<p>iOS用户需要使用美区帐号在App Store搜索下载"Shadowrocket"(需要付费，2.99美刀)</p>
									<p style="color:red">注意是Shadowrocket 不是shadowRocket 国内苹果账号搜到的是假的</p>
									<p>可以找管理员索要已经付费过的美区苹果帐号免费下载（登录后在App Store->更新->已购买里面）</p>
									<p>打开Shadowrocket软件后，点击右上角+号，添加类型为Subscribe，URL填写用户中心-iOS客户端下载处的订阅地址, 然后点击完成, 提示更新中, 顺利拉到服务器列表后点击未连接即可正确连接服务器</p>
									<div class="input-group">
										<div class="input-group-btn">
											<button id="ios_copy_button" type="button" class="btn btn-info" data-clipboard-action="copy" data-clipboard-target="#ios_link">复制订阅地址</button>
										</div>
										<!-- /btn-group -->
										<input id="ios_link" type="text" class="form-control" value="https://speedss.xyz/link/{$user->uuid}">
									</div>

								</div>
								<div class="tab-pane" id="tab_3">
									<p>Windows客户端&nbsp&nbsp
										<a class="btn btn-primary" href="/user/getwinzip">点击下载</a>
									</p>
									<p>下载后解压整个目录到桌面, 然后打开v2rayN.exe即可<br>（如果报毒请选择信任，关闭其他代理软件，确保运行正常）</p>
									<p>如果打开提示"请先安装.NET Framework", 先下载安装.net框架 <a href="https://download.speedss.xyz/dotNET_framework_4.6.2.exe">点我下载</a></p>
									<p>如有问题，可以远程协助，<a href="https://doc.speedss.xyz/%E8%BF%9C%E7%A8%8B%E5%8D%8F%E5%8A%A9%E6%B5%81%E7%A8%8B">协助流程</a></p>
								</div>
								<div class="tab-pane" id="tab_4">
									<p>Mac客户端&nbsp&nbsp
										<a class="btn btn-primary" href="https://download.speedss.xyz/V2RayX.app.zip">点击下载</a>
									</p>
									<p>新增透明代理模式(所有app走代理)</p>
									<p>下载后解压打开V2RayX.app, 然后输入订阅地址获取配置 (也可以在右上角app图标-服务器订阅处输入)</p>
									<p>如果提示身份不明的开发者, 需要到系统偏好设置->安全性与隐私->允许从以下位置下载的应用->仍要打开</p>
									<p>旧版(不支持透明代理)&nbsp&nbsp<a href="https://download.speedss.xyz/V2RayX.app.zip_old1">点击下载</a></p>
									<div class="input-group">
										<div class="input-group-btn">
											<button id="mac_copy_button" type="button" class="btn btn-info" data-clipboard-action="copy" data-clipboard-target="#mac_link">复制订阅地址</button>
										</div>
										<!-- /btn-group -->
										<input id="mac_link" type="text" class="form-control" value="https://speedss.xyz/link/{$user->uuid}">
									</div>
								</div>
								<div class="tab-pane" id="tab_5">
									<p>Linux客户端&nbsp&nbsp
										<a class="btn btn-primary" href="https://download.speedss.xyz/v2ray_2.42_linux_32_new.zip">点击下载</a>
									</p>
									<p>下载后需手动填写配置信息
										<a href="https://doc.speedss.xyz/temp">配置教程</a>（注意使用本网页上方的连接信息，教程的仅供参考）</p>
								</div>
							</div>
							<!-- /.tab-content -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<script src="/assets/public/js/client.min.js"></script>
		<script src="/assets/public/js/clipboard.min.js"></script>
		<script>
					var ios_clipboard = new ClipboardJS('#ios_copy_button');
					ios_clipboard.on('success', function (e) {
						alert("复制成功");
					});
					ios_clipboard.on('error', function (e) {
						console.log(e);
					});
					var android_clipboard = new ClipboardJS('#android_copy_button');
					android_clipboard.on('success', function (e) {
						alert("复制成功");
					});
					android_clipboard.on('error', function (e) {
						console.log(e);
					});
					var android_clipboard = new ClipboardJS('#mac_copy_button');
					android_clipboard.on('success', function (e) {
						alert("复制成功");
					});
					android_clipboard.on('error', function (e) {
						console.log(e);
					});
		</script>
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->
<div class="fixed-btn hidden-xs" id="referView">
	<img id="referImg" src="refer.png" width="100%" height="100%">
	<img id="referClose" src="close.png" style="position:absolute;top:-10%;left:88%;width:50px;height:50px;">
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
						});
						var timestamp = new Date().getTime();
						var localTimestampe = localStorage.getItem("timestamp");
						if (localTimestampe != null) {
							localTimestampe == parseInt(localTimestampe);
							if ((timestamp - localTimestampe) < 3600000) {
								$("#referView").hide();
							}
						}
						$("#referClose").click(function () {
							$("#referView").hide();
							localStorage.setItem("timestamp", timestamp);
						});
						$("#referImg").click(function () {
							localStorage.setItem("timestamp", timestamp);
							location.href = "/user/invite";
						});
					})

</script> {include file='user/footer.tpl'}