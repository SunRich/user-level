struct userlevel{
     1: i8 level
     2: double account
}

service accountlevel{
    //添加消费金额
    bool addAccount(1:i32 uid,2:double account)

    //获取一个用户的总消费，等级
   userlevel getUserAccountLevel(1:i32 uid)

   //获取一个用户的折扣
   double getUserDiscount(1:i32 uid)
}