<?php

namespace App\Services;

/***
 * Mail Service
 */

use App\Services\Mail\File;
use App\Services\Mail\Mailgun;
use App\Services\Mail\Ses;
use App\Services\Mail\Smtp;
use Smarty;
use PHPMailer;
use PHPMailer\PHPMailer\Exception;


class Mail
{
    /**
     * @return Mailgun|Ses|Smtp|null
     */
    public static function getClient()
    {
        $driver = Config::get("mailDriver");
        switch ($driver) {
            case "mailgun":
                return new Mailgun();
            case "ses":
                return new Ses();
            case "smtp":
                return new Smtp();
            case "file":
                return new File();
            default:
                // @TODO default action
        }
        return null;
    }

    /**
     * @param $template
     * @param $ary
     * @return mixed
     */
    public static function genHtml($template, $ary)
    {
        $smarty = new smarty();
        $smarty->settemplatedir(BASE_PATH . '/resources/email/');
        $smarty->setcompiledir(BASE_PATH . '/storage/framework/smarty/compile/');
        $smarty->setcachedir(BASE_PATH . '/storage/framework/smarty/cache/');
        // add config
        $smarty->assign('config', Config::getPublicConfig());
        $smarty->assign('analyticsCode', DbConfig::get('analytics-code'));
        foreach ($ary as $key => $value) {
            $smarty->assign($key, $value);
        }
        return $smarty->fetch($template);
    }

    /**
     * @param $to
     * @param $subject
     * @param $template
     * @param $ary
     * @param $file
     * @return bool|void
     */
    public static function send($to, $subject, $template, $ary = [], $file = [])
    {
        $text = self::genHtml($template, $ary);
        Logger::debug($text);
        // return self::getClient()->send($to, $subject, $text, $file);
        // 换phpmailer
        $mail= new PHPMailer(true);                  //建立新物件
        $mail->SMTPDebug = 0;                        
        $mail->IsSMTP();                         //設定使用SMTP方式寄信
        $mail->SMTPAuth = true;                  //設定SMTP需要驗證
        $mail->SMTPSecure = "ssl";               //Gmail的SMTP主機需要使用SSL連線
        $mail->Host = "smtp.gmail.com";          //Gamil的SMTP主機
        $mail->Port = 465;                       //Gamil的SMTP主機的埠號(Gmail為465)。
        $mail->CharSet = "utf-8";                //郵件編碼
        $mail->Username = "speedss.top@gmail.com";         //Gamil帳號
        $mail->Password = "a45685200";                     //Gmail密碼
        $mail->From = "speedss.top@gmail.com";             //寄件者信箱
        $mail->FromName = "Speedss";                       //寄件者姓名
        $mail->Subject = $subject;           //郵件標題
        $mail->Body = $text; //郵件內容
        $mail->IsHTML(true);                               //郵件內容為html
        $mail->AddAddress($to);             //收件者郵件及名稱
        $mail->Send();
    }
}