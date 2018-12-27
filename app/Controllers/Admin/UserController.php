<?php

namespace App\Controllers\Admin;

use App\Controllers\AdminController;
use App\Models\User;
use App\Models\Node;
use App\Models\Order;
use App\Models\UserInfo;
use App\Utils\Hash;
use App\Utils\Tools;

class UserController extends AdminController
{
    public function index($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $users = User::orderBy('id', 'desc')->paginate(100, ['*'], 'page', $pageNum);
        $users->setPath('/admin/user');
        return $this->view()->assign('users', $users)->display('admin/user/index.tpl');
    }

    public function order($request, $response, $args) 
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $orders = Order::orderBy('id', 'desc')->paginate(100, ['*'], 'page', $pageNum);
        return $this->view()->assign('orders', $orders)->display('admin/order.tpl');
    }

    public function orderPass($request, $response, $args)
    {
        $id = $args['id'];
        $order = Order::find($id);
        $user = User::find($order->user_id);
        $order->order_status = "已完成";
        $user->payment_date = $order->payment_date;
        $user->payment_day = $order->payment_day;
        $user->payment_name = $order->payment_name;
        $user->save();
        $order->save();

        // 邀请返利
        date_default_timezone_set('Asia/Shanghai');
        $referUser = User::find($user->ref_by);
        if ($referUser->payment_date > time()) {
            // 没过期则累加
            if ($order->payment_name == "季度套餐") {
                $referUser->payment_date = strtotime(date('Y-m-d H:i:s', $referUser->payment_date) . " +1 month");
            } else if ($order->payment_name == "半年套餐") {
                $referUser->payment_date = strtotime(date('Y-m-d H:i:s', $referUser->payment_date) . " +2 month");
            } else if ($order->payment_name == "一年套餐") {
                $referUser->payment_date = strtotime(date('Y-m-d H:i:s', $referUser->payment_date) . " +4 month");
            }
        } else {
            // 过期则当前时间加
            if ($order->payment_name == "季度套餐") {
                $referUser->payment_date = strtotime(" +1 month");
            } else if ($order->payment_name == "半年套餐") {
                $referUser->payment_date = strtotime(" +2 month");
            } else if ($order->payment_name == "一年套餐") {
                $referUser->payment_date = strtotime(" +4 month");
            }
        }
        
        $referUser->save();

        $newResponse = $response->withStatus(302)->withHeader('Location', '/admin/order');
        return $newResponse;
    }

    public function orderRemarks($request, $response, $args)
    {
        $id = $args['id'];
        $order = Order::find($id);
        return $this->view()->assign('order', $order)->display('admin/orderremarks.tpl');
    }

    public function orderRemarksAdd($request, $response, $args)
    {
        $id = $request->getParam('id');
        $content = $request->getParam('content');
        $order = Order::find($id);
        $order->remarks = $content;
        if (!$order->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "添加失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "添加成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function userInfo($request, $response, $args)
    {
        $pageNum = 1;
        if (isset($request->getQueryParams()["page"])) {
            $pageNum = $request->getQueryParams()["page"];
        }
        $userInfos = UserInfo::orderBy('id', 'desc')->paginate(100, ['*'], 'page', $pageNum);
        return $this->view()->assign('userInfos', $userInfos)->display('admin/userinfo.tpl');
    }

    public function userInfoHidden($request, $response, $args)
    {
        $id = $args['id'];
        $userInfo = UserInfo::find($id);
        if ($userInfo->hidden == 0) {
            $userInfo->hidden = 1;
        } else {
            $userInfo->hidden = 0;
        }
        $userInfo->save();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/admin/userinfo');
        return $newResponse;
    }

    public function userInfoEdit($request, $response, $args)
    {
        $id = $args['id'];
        $userInfo = UserInfo::find($id);
        return $this->view()->assign('userInfo', $userInfo)->display('admin/userinfoedit.tpl');
    }

    public function userInfoEditPost($request, $response, $args)
    {
        $id = $request->getParam('id');
        $content = $request->getParam('content');
        $hidden = $request->getParam('hidden');
        $userInfo = UserInfo::find($id);
        $userInfo->content = $content;
        $userInfo->hidden = $hidden;
        if (!$userInfo->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "修改失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function userInfoNew($request, $response, $args)
    {
        return $this->view()->display('admin/userinfonew.tpl');        
    }

    public function userInfoNewHandle($request, $response, $args)
    {
        $content = $request->getParam('content');
        $hidden = $request->getParam('hidden');
        $userInfo = new UserInfo();
        $userInfo->content = $content;
        $userInfo->hidden = $hidden;
        if (!$userInfo->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "保存失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "保存成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function userInfoDelete($request, $response, $args)
    {
        $id = $args['id'];
        $userInfo = UserInfo::find($id);
        $userInfo->delete();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/admin/userinfo');
        return $newResponse;
    }


    public function edit($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);
        if ($user == null) {

        }
        $method = Node::getCustomerMethod();
        return $this->view()->assign('user', $user)->assign('method', $method)->display('admin/user/edit.tpl');
    }

    public function update($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);

        $user->email = $request->getParam('email');
        if ($request->getParam('pass') != '') {
            $user->pass = Hash::passwordHash($request->getParam('pass'));
        }
        if ($request->getParam('passwd') != '') {
            $user->passwd = $request->getParam('passwd');
        }
        $user->port = $request->getParam('port');
        $user->transfer_enable = Tools::toGB($request->getParam('transfer_enable'));
        $user->invite_num = $request->getParam('invite_num');
        $user->method = $request->getParam('method');
        $user->enable = $request->getParam('enable');
        $user->is_admin = $request->getParam('is_admin');
        $user->ref_by = $request->getParam('ref_by');
        // 时间戳的逻辑就是当前时间戳加上增加天数换算的时间戳
        // $user->payment_date = time()+($request->getParam('payment_day'))*3600*24;
        // $user->payment_day = $request->getParam('payment_day');
        // $user->payment_name = $request->getParam('payment_day') . "天套餐";
        // 指定有效期到指定日期
        date_default_timezone_set("Asia/Shanghai");
        $user->payment_date = strtotime($request->getParam('payment_date'));
        
        if (!$user->save()) {
            $rs['ret'] = 0;
            $rs['msg'] = "修改失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "修改成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function delete($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);
        if (!$user->delete()) {
            $rs['ret'] = 0;
            $rs['msg'] = "删除失败";
            return $response->getBody()->write(json_encode($rs));
        }
        $rs['ret'] = 1;
        $rs['msg'] = "删除成功";
        return $response->getBody()->write(json_encode($rs));
    }

    public function deleteGet($request, $response, $args)
    {
        $id = $args['id'];
        $user = User::find($id);
        $user->delete();
        $newResponse = $response->withStatus(302)->withHeader('Location', '/admin/user');
        return $newResponse;
    }

    public function checkPaymentStatus($request, $response, $args)
    {
        $users = User::all();
        date_default_timezone_set("Asia/Shanghai");
        foreach ($users as $user) {
            if ($user->payment_date > time()) {
                $user->payment_status = "有效";
            } else {
                $user->payment_status = "已过期";
            }
            $user->save();
        }
        $newResponse = $response->withStatus(302)->withHeader('Location', '/admin/user');
        return $newResponse;
    }
}
