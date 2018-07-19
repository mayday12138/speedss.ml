{include file='admin/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            节点列表
            <small>Node List</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-md-7">
                <!--<p> <a class="btn btn-success btn-sm" href="/admin/node/create">添加</a> </p>-->
                <div class="box">
                    <div class="box-body table-responsive no-padding">
                        <table class="table table-hover">
                            <tr>
                                <th>节点</th>
                                <th>主机位置</th>
                                <th>最后更新</th>
                                <th>状态</th>
                            </tr>
                            {foreach $nodes as $ip=>$dict}
                            <tr>
                                <td>{$ip}</td>
                                <td>{$dict["address"]}</td>
                                <td>{date('Y-m-d H:i:s', $dict["time"])}</td>
                                {if (time()-$dict["time"]) < 1800}
                                <td>在线</td>
                                {else}
                                <td>___</td>
                                {/if}
                            </tr>
                            {/foreach}
                        </table>
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->

{include file='admin/footer.tpl'}