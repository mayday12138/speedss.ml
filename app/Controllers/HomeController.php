<?php

namespace App\Controllers;

//use Psr\Http\Message\ServerRequestInterface as Request;
//use Psr\Http\Message\ResponseInterface as Response;
use Slim\Http\Request;
use Slim\Http\Response;

use App\Models\InviteCode;
use App\Models\V2rayNode;
use App\Models\User;
use App\Services\Auth;
use App\Services\Config;
use App\Services\DbConfig;
use App\Services\Logger;
use App\Utils\Check;
use App\Utils\Http;
use App\Utils\Hash;

/**
 *  HomeController
 */
class HomeController extends BaseController
{

    public function index($request, $response, $args)
    {
        //$homeIndexMsg = DbConfig::get('home-index');
        //return $this->view()->assign('homeIndexMsg', $homeIndexMsg)->display('index.tpl');
        return $this->redirect($response, '/auth/login');
    }

    public function intro()
    {
        //return $this->redirect($response, '/auth/login');
        return $this->view()->display('intro.tpl');
    }

    public function configclient()
    {
        return $this->view()->display('configclient.tpl');
    }

    public function getServerConfig($request, $response, $args)
    {
        $email = $request->getParam('email');
        $email = strtolower($email);
        $passwd = $request->getParam('passwd');
        $user = User::where('email', '=', $email)->first();
        if ($user == null) {
            $res['ret'] = 0;
            $res['msg'] = "邮箱或者密码错误";
            return $this->echoJson($response, $res);
        }
        if (!Hash::checkPassword($user->pass, $passwd)) {
            $res['ret'] = 0;
            $res['msg'] = "邮箱或者密码错误";
            return $this->echoJson($response, $res);
        }
        // 从v2ray_node读取配置
        $nodes = v2rayNode::all();
        $configJson = [];
        foreach ($nodes as $node) {
            $addNode["address"] = $node->address;
            $addNode["port"] = (int)$node->port;
            $addNode["id"] = $user->uuid;
            $addNode["alterId"] = (int)$node->alter_id;
            $addNode["security"] = $node->security;
            $addNode["network"] = $node->getWebsocketAlias();
            $addNode["remarks"] = $node->name;
            $addNode["headerType"] = $node->type;
            $addNode["requestHost"] = $node->path;
            $addNode["streamSecurity"] = $node->getTlsAlias();
            array_push($configJson, $addNode);
        }
        return $this->echoJson($response, $configJson);
    }

    public function getAndroidServerConfig($request, $response, $args)
    {
        $email = $request->getParam('email');
        $email = strtolower($email);
        $passwd = $request->getParam('passwd');
        $user = User::where('email', '=', $email)->first();
        if ($user == null) {
            $res['ret'] = 0;
            $res['msg'] = "邮箱或者密码错误";
            return $this->echoJson($response, $res);
        }
        if (!Hash::checkPassword($user->pass, $passwd)) {
            $res['ret'] = 0;
            $res['msg'] = "邮箱或者密码错误";
            return $this->echoJson($response, $res);
        }
        // 从v2ray_node读取配置
        $nodes = v2rayNode::all();
        $configJson = [];
        foreach ($nodes as $node) {
            $addNode["add"] = $node->address;
            $addNode["ps"] = $node->name;
            $addNode["port"] = $node->port;
            $addNode["id"] = $user->uuid;
            $addNode["aid"] = $node->alter_id;
            $addNode["net"] = $node->getWebsocketAlias();
            $addNode["host"] = $node->path;
            $addNode["tls"] = $node->getTlsAlias();
            $addNode["type"] = $node->type;
            $addNodeStr = json_encode($addNode);
            $addNodeStr = base64_encode($addNodeStr);
            $addNodeStr = "vmess://" . $addNodeStr;
            array_push($configJson, $addNodeStr);
        }
        echo json_encode($configJson, JSON_UNESCAPED_SLASHES);
        return $response->withHeader('Content-type', 'text/plain');
    }

    public function link($request, $response, $args)
    {
        $uuid = $args['uuid'];
        $user = User::where('uuid', '=', $uuid)->first();
        if ($user == null) {
            $res['ret'] = 0;
            $res['msg'] = "uuid不存在";
            return $this->echoJson($response, $res);
        }
        // 判断设备类型
        $headerArray = $request->getHeader('User-Agent');
        if (strpos($headerArray[0], 'okhttp') !== false) {
            if (strpos($headerArray[0], 'okhttp/3.5.0') !== false) {
                // v2rayNG
                $nodes = v2rayNode::all();
                $configJson = [];
                foreach ($nodes as $node) {
                    $addNode["add"] = $node->address;
                    $addNode["ps"] = $node->name;
                    $addNode["port"] = $node->port;
                    $addNode["id"] = $user->uuid;
                    $addNode["aid"] = $node->alter_id;
                    $addNode["net"] = $node->getWebsocketAlias();
                    $addNode["host"] = $node->path;
                    $addNode["tls"] = $node->getTlsAlias();
                    $addNode["type"] = $node->type;
                    $addNodeStr = json_encode($addNode);
                    $addNodeStr = base64_encode($addNodeStr);
                    $addNodeStr = "vmess://" . $addNodeStr;
                    array_push($configJson, $addNodeStr);
                }
                echo json_encode($configJson, JSON_UNESCAPED_SLASHES);
                return $response->withHeader('Content-type', 'text/plain');
            } else {
                // BifrostV okhttp/3.10.0
                $nodes = v2rayNode::all();
                $links = "";
                foreach ($nodes as $node) {
                    if ($node->port == "80") {
                        $link = "bfv://" . $node->address . ":" . $node->port . "/vmess/1?rtype=lanchina&dns=8.8.8.8&tnet=ws&aid=0&sec=aes-128-cfb&ws=path=/v2ray/" . "&uid=" . $user->uuid . "&headers=#" . urlencode($node->name) . "\n";
                        $links = $links . $link;
                    } else {
                        $link = "bfv://" . $node->address . ":" . $node->port . "/vmess/1?rtype=lanchina&dns=8.8.8.8&tnet=ws&tsec=tls&ttlsa=1&aid=0&sec=aes-128-cfb&ws=path=/v2ray/" . "&uid=" . $user->uuid . "&headers=#" . urlencode($node->name) . "\n";
                        $links = $links . $link;
                    }
                }
                echo $links;
                return $response->withHeader('Content-type', 'text/plain');
            }
        } else if (strpos($headerArray[0], 'V2RayX') !== false) {
            // V2rayX
            $nodes = v2rayNode::all();
            $configJson = [];
            foreach ($nodes as $node) {
                $addNode["add"] = $node->address;
                $addNode["ps"] = $node->name;
                $addNode["port"] = $node->port;
                $addNode["id"] = $user->uuid;
                $addNode["aid"] = $node->alter_id;
                $addNode["net"] = $node->getWebsocketAlias();
                $addNode["host"] = $node->path;
                $addNode["tls"] = $node->getTlsAlias();
                $addNode["type"] = $node->type;
                $addNodeStr = json_encode($addNode);
                $addNodeStr = base64_encode($addNodeStr);
                $addNodeStr = "vmess://" . $addNodeStr;
                array_push($configJson, $addNodeStr);
            }
            echo json_encode($configJson, JSON_UNESCAPED_SLASHES);
            return $response->withHeader('Content-type', 'text/plain');
        } else {
            // Shadowrocket user-agent是随机的
            $nodes = v2rayNode::all();
            $links = "";
            foreach ($nodes as $node) {
                $link = "vmess://" . base64_encode($node->security . ":" . $user->uuid . "@" . $node->address . ":" . $node->port) . "?obfs=" . $node->network . "&path=" . $node->path . "&tls=" .$node->tls . "&remarks=" .base64_encode($node->name) . "&group=" . base64_encode("speedss.xyz") . "\n";
                $links = $links . $link;
            }
            echo base64_encode($links);
            return $response->withHeader('Content-type', 'text/plain');
        }
    }

    public function code()
    {
        $msg = DbConfig::get('home-code');
        $codes = InviteCode::where('user_id', '=', '0')->take(10)->get();
        return $this->view()->assign('codes', $codes)->assign('msg', $msg)->display('code.tpl');
    }

    public function debug($request, $response, $args)
    {
        $server = [
            "headers" => $request->getHeaders(),
            "content_type" => $request->getContentType()
        ];
        $res = [
            "server_info" => $server,
            "ip" => Http::getClientIP(),
            "version" => Config::get('version'),
            "reg_count" => Check::getIpRegCount(Http::getClientIP()),
        ];
        Logger::debug(json_encode($res));
        return $this->echoJson($response, $res);
    }

    public function tos()
    {
        return $this->view()->display('tos.tpl');
    }

    public function postDebug(Request $request,Response $response, $args)
    {
        $res = [
            "body" => $request->getBody(), 
            "params" => $request->getParams() 
        ];
        return $this->echoJson($response, $res);
    }

}
