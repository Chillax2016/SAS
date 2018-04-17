/****************************************************/
/*示例                                              */
/*假定您希望在远程主机上执行某些处理，                */
/*然后下载 SAS 结果数据集，在本地主机上创建永久数据集，*/
/*最后在本地主机上打印报表。                         */
/*下例将说明如何将上述所有任务编入一个程序。          */
/***************************************************/


   /*************************************/
   /* prepare to sign on                */
   /*************************************/

/*OPTIONS 语句指定 COMAMID= 和 REMOTE= 系统选项。*/
/*这两个系统选项将为本地会话定义希望建立链接的远程主机以及链接类型。*/
options comamid=netbios remote=netpc; 

/*LIBNAME 语句为本地会话中要存储下载数据集的 SAS 逻辑库定义了逻辑库引用名。*/
libname lhost 'c:\sales\reg1';

   /*************************************/
   /* sign on and download data set     */
   /*************************************/
/*SIGNON 语句用来登录远程主机。                                                 */
/*若已经在前面的 OPTIONS 语句中定义了 REMOTE= 系统选项，则在此不必指定远程会话 ID。*/
signon;
/*RSUBMIT 语句将上述语句发送到远程会话进行处理。*/
/*所有语句都将发送到远程会话，直至 ENDRSUBMIT 语句。*/
/*尽管不必指定远程会话 ID，但若有多个链接处于活动状态，则在 RSUBMIT 语句中使用远程会话 ID 可明确指定处理语句组的远程会话。
/*若省略远程会话 ID，RSUBMIT 语句就会将语句提交给 SIGNON 、RSUBMIT 语句或 REMOTE= 系统选项中最后标识的远程会话。*/
rsubmit;

/*LIBNAME 语句定义了远程主机上的 SAS 逻辑库的逻辑库引用名。*/
libname rhost 'd:\dept12';
proc sort data=rhost.master 
   out=rhost.sales;
where gross > 5000;
by lastname dept;
run;

/*PROC DOWNLOAD 步将远程主机 (RHOST) 上的逻辑库中的数据传输到本地主机 (LHOST) 上的逻辑库。*/
proc download data=rhost.sales 
   out=lhost.sales;
run;

/*ENDRSUBMIT 语句标志着需要提交到远程会话的语句块的结束， ENDRSUBMIT 语句之后的语句将由本地会话处理。*/
endrsubmit;
   /*************************************/
   /* print data set in local session   */
   /*************************************/
proc print data=lhost.sales;
run;
 

