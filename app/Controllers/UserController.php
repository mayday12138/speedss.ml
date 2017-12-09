<?php

namespace App\Controllers;

use App\Models\CheckInLog;
use App\Models\InviteCode;
use App\Models\Node;
use App\Models\TrafficLog;
use App\Models\Order;
use App\Models\V2rayNode;
use App\Models\UserInfo;
// use App\Models\Plan;
use App\Services\Auth;
use App\Services\Config;
use App\Services\DbConfig;
use App\Utils\Hash;
use App\Utils\Tools;


/**
 *  HomeController
 */
class UserController extends BaseController
{

    private $user;

    public function __construct()
    {
        $this->user = Auth::getUser();
    }

    public function view()
    {
        $userFooter = DbConfig::get('user-footer');
        return parent::view()->assign('userFooter', $userFooter);
    }

    public function index($request, $response, $args)
    {
        $msg = DbConfig::get('user-index');
        if ($msg == null) {
            $msg = "在后台修改用户中心公告...";
        }
        $v2ray_node_1 = V2rayNode::where("id", 1)->first();
        $v2ray_node_2 = V2rayNode::where("id", 2)->first();

        // android的二维码 主服
        $ary['add'] = $v2ray_node_1->address;
        $ary['ps'] = $v2ray_node_1->address;
        $ary['port'] = $v2ray_node_1->port;
        $ary['id'] = $this->user->uuid;
        $ary['security'] = $v2ray_node_1->security;
        $ary['aid'] = $v2ray_node_1->alter_id;
        if ($v2ray_node_1->network == "websocket"){
            $ary['net'] = "ws";
        }
        $ary['host'] = $v2ray_node_1->path;
        if ($v2ray_node_1->tls == "1"){
            $ary['tls'] = "tls";
        }
        $ary['type'] = $v2ray_node_1->type;
        $json = json_encode($ary);
        $v2ray_qr_1_android = "vmess://" . base64_encode($json);

        // android的二维码 备用服
        $ary2['add'] = $v2ray_node_2->address;
        $ary2['ps'] = $v2ray_node_2->address;
        $ary2['port'] = $v2ray_node_2->port;
        $ary2['id'] = $this->user->uuid;
        $ary2['security'] = $v2ray_node_2->security;
        $ary2['aid'] = $v2ray_node_2->alter_id;
        if ($v2ray_node_2->network == "websocket"){
            $ary2['net'] = "ws";
        }
        $ary2['host'] = $v2ray_node_2->path;
        if ($v2ray_node_2->tls == "1"){
            $ary2['tls'] = "tls";
        }
        $ary2['type'] = $v2ray_node_2->type;
        $json2 = json_encode($ary2);
        $v2ray_qr_2_android = "vmess://" . base64_encode($json2);

        // iOS的二维码 主服
        // aes-128-cfb:c4a3ffd1-e874-4dac-a522-9ca0058b2156@v2ray-nginx.speedss.ml:443?obfs=websocket&path=/v2ray/&tls=1
        $v2ray_qr_1_ios = "vmess://" . base64_encode($v2ray_node_1->security . ":" . $this->user->uuid . "@" . $v2ray_node_1->address . ":" . $v2ray_node_1->port) . "?obfs=" . $v2ray_node_1->network . "&path=" . $v2ray_node_1->path . "&tls=" .$v2ray_node_1->tls;
        $v2ray_qr_2_ios = "vmess://" . base64_encode($v2ray_node_2->security . ":" . $this->user->uuid . "@" . $v2ray_node_2->address . ":" . $v2ray_node_2->port) . "?obfs=" . $v2ray_node_2->network . "&path=" . $v2ray_node_2->path . "&tls=" .$v2ray_node_2->tls;

        $userInfos = UserInfo::where("hidden", 0)->orderBy('id','desc')->get();
        return $this->view()->assign('v2ray_qr_1_android', $v2ray_qr_1_android)
                            ->assign('v2ray_qr_2_android', $v2ray_qr_2_android)
                            ->assign('v2ray_qr_1_ios', $v2ray_qr_1_ios)
                            ->assign('v2ray_qr_2_ios', $v2ray_qr_2_ios)
                            ->assign('userInfos', $userInfos)
                            ->assign('v2ray_node_1', $v2ray_node_1)
                            ->assign('v2ray_node_2', $v2ray_node_2)
                            ->assign('msg', $msg)
                            ->display('user/index.tpl');
    }

    public function getclient($request, $response, $args)
    {
        $hk1 = $this->getSSURL(1); //hk1
        $us1 = $this->getSSURL(2); //us1
        $jp1 = $this->getSSURL(4); //jp1
        return $this->view()->assign('hk1', $hk1)->assign('us1', $us1)->assign('jp1', $jp1)->display('user/getclient.tpl');
    }

    public function payment($request, $response, $args)
    {
        // $plans = Plan::orderBy('id','DESC')->get();
        // return $this->view()->assign('plans',$plans)->display('user/payment.tpl');
        return $this->view()->display('user/payment.tpl');        
    }

    public function paymentHandle($request, $response, $args)
    {
        $paymentType = $request->getParam('paymentType');
        // 如果已经有待付款订单 则更新该订单
        $order = Order::where('user_id', $this->user->id)->where('order_status','待付款')->first();
        if ($order != null && $order->count() > 0){
            // 使用已经产生的订单
        } else {
            // 产生订单
            $order = new Order();
        }
        // 如果已经有已完成订单，则在上次完成时间上累加(还没有过期)
        $completeOrder = Order::where('user_id', $this->user->id)->where('order_status','已完成')->orderBy('id','desc')->first();
        date_default_timezone_set('Asia/Shanghai');
        if ($completeOrder != null && $completeOrder->count() > 0 && $completeOrder->payment_date > time()) {
            $order->user_id = $this->user->id;
            $order->user_name = $this->user->user_name;
            $order->user_email = $this->user->email;
            if ($paymentType == "1month"){
                $order->payment_date = strtotime(date('Y-m-d H:i:s', $completeOrder->payment_date) . ' +1 month');
                $order->payment_day = 30;
                $order->payment_name = "包月套餐";
            }
            if ($paymentType == "6month"){
                $order->payment_date = strtotime(date('Y-m-d H:i:s', $completeOrder->payment_date) . ' +6 month');
                $order->payment_day = 180;
                $order->payment_name = "半年套餐";
            }
            if ($paymentType == "1year"){
                $order->payment_date = strtotime(date('Y-m-d H:i:s', $completeOrder->payment_date) . ' +1 year');
                $order->payment_day = 360;
                $order->payment_name = "一年套餐";
            }
            if ($paymentType == "2year"){
                $order->payment_date = strtotime(date('Y-m-d H:i:s', $completeOrder->payment_date) . ' +2 year');
                $order->payment_day = 720;
                $order->payment_name = "两年套餐";
            }
        } else {
            // 如果没有已完成的 那就在当前时间上累加
            // 还有一种情况有完成但是已过期的也是这种模式
            $order->user_id = $this->user->id;
            $order->user_name = $this->user->user_name;
            $order->user_email = $this->user->email;
            if ($paymentType == "1month"){
                $order->payment_date = strtotime("+1 month");
                $order->payment_day = 30;
                $order->payment_name = "包月套餐";
            }
            if ($paymentType == "6month"){
                $order->payment_date = strtotime("+6 month");
                $order->payment_day = 180;
                $order->payment_name = "半年套餐";
            }
            if ($paymentType == "1year"){
                $order->payment_date = strtotime("+1 year");
                $order->payment_day = 360;
                $order->payment_name = "一年套餐";
            }
            if ($paymentType == "2year"){
                $order->payment_date = strtotime("+2 year");
                $order->payment_day = 720;
                $order->payment_name = "两年套餐";
            }
        }
        
        if (!$order->save()){
            $res['ret'] = 0;
            $res['msg'] = "订单提交失败";
            return $response->getBody()->write(json_encode($res));
        } else {
            $res['ret'] = 1;
            $res['msg'] = "订单提交成功";
            return $this->echoJson($response, $res);
        }
    }

    public function order($request, $response, $args) 
    {
        $orders = Order::where('user_id', '=', $this->user->id)->orderBy('id', 'desc')->get();
        return $this->view()->assign('orders', $orders)->display('user/order.tpl');
    }

    public function getWinZip($request, $response, $args)
    {
        // 从v2ray_node读取配置
        $nodes = v2rayNode::all();
        // 读取配置文件
        $configStr = file_get_contents("./downloads/v2rayN/guiNConfig.json");
        $configJson = json_decode($configStr, true);
        // unset($configJson["vmess"]);
        $configJson["vmess"] = [];
        foreach ($nodes as $node) {
            $addNode["address"] = $node->address;
            $addNode["port"] = (int)$node->port;
            $addNode["id"] = $this->user->uuid;
            $addNode["alterId"] = (int)$node->alter_id;
            $addNode["security"] = $node->security;
            $addNode["network"] = $node->getWebsocketAlias();
            $addNode["remarks"] = $node->address;
            $addNode["headerType"] = $node->type;
            $addNode["requestHost"] = $node->path;
            $addNode["streamSecurity"] = $node->getTlsAlias();
            array_push($configJson["vmess"], $addNode);
        }
        // var_dump($configJson);
        $fp = fopen("./downloads/v2rayN/guiNConfig.json", 'w');
        if ($fp) {
            fwrite($fp, json_encode($configJson, JSON_PRETTY_PRINT|JSON_UNESCAPED_SLASHES));
            fclose($fp);
            // 修改配置
            // 打包
            // echo shell_exec("tar -czvf ./downloads/v2rayN_win.zip -C ./downloads/v2rayN .");
            echo shell_exec("cd ./downloads;rm -f v2rayN_win.zip;zip -r v2rayN_win.zip ./v2rayN;cd ..");
            $newResponse = $response->withStatus(302)->withHeader('Location', "/downloads/v2rayN_win.zip");
            return $newResponse;
        } else {
            echo "permission denied.";
        }
    }

    function watchVideo($request, $response, $args) {
        return $this->view()->display('user/watchvideo.tpl');
    }

    function getSSURL($node)
    {
        $node = Node::find($node);
        if ($node == null) {}
        $ary['server'] = $node->server;
        $ary['server_port'] = $this->user->port;
        $ary['password'] = $this->user->passwd;
        $ary['method'] = $node->method;
        if ($node->custom_method) {
            $ary['method'] = $this->user->method;
        }
        $json = json_encode($ary);
        $json_show = json_encode($ary, JSON_PRETTY_PRINT);
        $ssurl = $ary['method'] . ":" . $ary['password'] . "@" . $ary['server'] . ":" . $ary['server_port'];
        $ssqr = "ss://" . base64_encode($ssurl);
        return $ssqr;
    }

    public function node($request, $response, $args)
    {
        $msg = DbConfig::get('user-node');
        $user = Auth::getUser();
        $nodes = Node::where('type', 1)->orderBy('sort')->get();
        return $this->view()->assign('nodes', $nodes)->assign('user', $user)->assign('msg', $msg)->display('user/node.tpl');
    }


    public function nodeInfo($request, $response, $args)
    {
        $id = $args['id'];
        $node = Node::find($id);

        if ($node == null) {

        }
        $ary['server'] = $node->server;
        $ary['server_port'] = $this->user->port;
        $ary['password'] = $this->user->passwd;
        $ary['method'] = $node->method;
        if ($node->custom_method) {
            $ary['method'] = $this->user->method;
        }
        $json = json_encode($ary);
        $json_show = json_encode($ary, JSON_PRETTY_PRINT);
        $ssurl = $ary['method'] . ":" . $ary['password'] . "@" . $ary['server'] . ":" . $ary['server_port'];
        $ssqr = "ss://" . base64_encode($ssurl);

        $surge_base = Config::get('baseUrl') . "/downloads/ProxyBase.conf";
        $surge_proxy = "#!PROXY-OVERRIDE:ProxyBase.conf\n";
        $surge_proxy .= "[Proxy]\n";
        $surge_proxy .= "Proxy = custom," . $ary['server'] . "," . $ary['server_port'] . "," . $ary['method'] . "," . $ary['password'] . "," . Config::get('baseUrl') . "/downloads/SSEncrypt.module";
        return $this->view()->assign('json', $json)->assign('json_show', $ary)->assign('ssqr', $ssqr)->assign('surge_base', $surge_base)->assign('surge_proxy', $surge_proxy)->display('user/nodeinfo.tpl');
    }

    public function profile($request, $response, $args)
    {
        return $this->view()->display('user/profile.tpl');
    }

    public function edit($request, $response, $args)
    {
        $method = Node::getCustomerMethod();
        return $this->view()->assign('method', $method)->display('user/edit.tpl');
    }


    public function invite($request, $response, $args)
    {
        $codes = $this->user->inviteCodes();
        return $this->view()->assign('codes', $codes)->display('user/invite.tpl');
    }

    public function doInvite($request, $response, $args)
    {
        //$n = $this->user->invite_num;
        $n = 1;
	    if ($n < 1) {
            $res['ret'] = 0;
            return $response->getBody()->write(json_encode($res));
        }
        for ($i = 0; $i < $n; $i++) {
            $char = Tools::genRandomChar(32);
            $code = new InviteCode();
            $code->code = $char;
            $code->user_id = $this->user->id;
            $code->save();
        }
        $this->user->invite_num = 0;
        $this->user->save();
        $res['ret'] = 1;
        return $this->echoJson($response, $res);
    }

    public function sys($request, $response, $args)
    {
        return $this->view()->assign('ana', "")->display('user/sys.tpl');
    }

    public function updatePassword($request, $response, $args)
    {
        $oldpwd = $request->getParam('oldpwd');
        $pwd = $request->getParam('pwd');
        $repwd = $request->getParam('repwd');
        $user = $this->user;
        if (!Hash::checkPassword($user->pass, $oldpwd)) {
            $res['ret'] = 0;
            $res['msg'] = "旧密码错误";
            return $response->getBody()->write(json_encode($res));
        }
        if ($pwd != $repwd) {
            $res['ret'] = 0;
            $res['msg'] = "两次输入不符合";
            return $response->getBody()->write(json_encode($res));
        }

        if (strlen($pwd) < 8) {
            $res['ret'] = 0;
            $res['msg'] = "密码太短啦";
            return $response->getBody()->write(json_encode($res));
        }
        $hashPwd = Hash::passwordHash($pwd);
        $user->pass = $hashPwd;
        $user->save();

        $res['ret'] = 1;
        $res['msg'] = "密码修改成功";
        return $this->echoJson($response, $res);
    }

    public function updateSsPwd($request, $response, $args)
    {
        $user = Auth::getUser();
        $pwd = $request->getParam('sspwd');
        if (strlen($pwd) == 0) {
            $pwd = Tools::genRandomChar(8);
        } elseif (strlen($pwd) < 5) {
            $res['ret'] = 0;
            $res['msg'] = "密码要大于4位或者留空生成随机密码";
            return $response->getBody()->write(json_encode($res));;
        }
        $user->updateSsPwd($pwd);
        $res['ret'] = 1;
        $res['msg'] = sprintf("新密码为: %s", $pwd);
        return $this->echoJson($response, $res);
    }

    public function updateMethod($request, $response, $args)
    {
        $user = Auth::getUser();
        $method = $request->getParam('method');
        $method = strtolower($method);
        $user->updateMethod($method);
        $res['ret'] = 1;
        return $this->echoJson($response, $res);
    }

    public function logout($request, $response, $args)
    {
        Auth::logout();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/auth/login');
        return $newResponse;
    }

    public function doCheckIn($request, $response, $args)
    {
        if (!$this->user->isAbleToCheckin()) {
            $res['msg'] = "您似乎已经签到过了...";
            $res['ret'] = 1;
            return $response->getBody()->write(json_encode($res));
        }
        $traffic = rand(Config::get('checkinMin'), Config::get('checkinMax'));
        $trafficToAdd = Tools::toMB($traffic);
        $this->user->transfer_enable = $this->user->transfer_enable + $trafficToAdd;
        $this->user->last_check_in_time = time();
        $this->user->save();
        // checkin log
        try {
            $log = new CheckInLog();
            $log->user_id = Auth::getUser()->id;
            $log->traffic = $trafficToAdd;
            $log->checkin_at = time();
            $log->save();
        } catch (\Exception $e) {
        }
        $res['msg'] = sprintf("获得了 %u MB流量.", $traffic);
        $res['ret'] = 1;
        return $this->echoJson($response, $res);
    }

    public function kill($request, $response, $args)
    {
        return $this->view()->display('user/kill.tpl');
    }

    public function handleKill($request, $response, $args)
    {
        $user = Auth::getUser();
        $passwd = $request->getParam('passwd');
        // check passwd
        $res = array();
        if (!Hash::checkPassword($user->pass, $passwd)) {
            $res['ret'] = 0;
            $res['msg'] = " 密码错误";
            return $this->echoJson($response, $res);
        }
        Auth::logout();
        $user->delete();
        $res['ret'] = 1;
        $res['msg'] = "GG!您的帐号已经从我们的系统中删除.";
        return $this->echoJson($response, $res);
    }

    public function trafficLog($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $traffic = TrafficLog::where('user_id', $this->user->id)->orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
        $traffic->setPath('/user/trafficlog');
        return $this->view()->assign('logs', $traffic)->display('user/trafficlog.tpl');
    }
}
