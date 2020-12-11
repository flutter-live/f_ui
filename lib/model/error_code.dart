/// @description: 错误码
///@date: 2020/12/3 10

class ErrorCode {
  ///成功
  static const String ALL_OK = "00000";

  ///用户未登录
  static const String NO_USER_LOGIN = "A0231";

  ///参数已存在
  static const String PARAMETER_ALREADY_EXISTS = "A0450";

  ///新密码不能与原密码一致
  static const String NEW_OLD_PASSWORD_NOT_MATCH = "A0126";

  ///用户端错误
  static const String CLIENT_ERROR = "A0001";

  ///用户注册错误
  static const String REGISTY_ERROR = "A0100";

  ///用户未同意隐私协议
  static const String USER_NOTAGREE_AGREEMENT = "A0101";

  ///注册国家或地区受限
  static const String REGISTRATION_COUNTRY_LIMIT = "A0102";

  ///用户名校验失败
  static const String USERNAME_CHECK_FAIL = "A0110";

  ///用户名已存在
  static const String USERNAME_EXISTS = "A0111";

  ///用户名包含敏感词
  static const String USERNAME_CONTAIN_SENSITIE_WORDS = "A0112";

  ///用户名包含特殊字符
  static const String USERNAME_CONTAIN_SPECIAL_CHARACTERS = "A0113";

  ///密码校验失败
  static const String PASSWORD_CHECK_FAIL = "A0120";

  ///密码长度不够
  static const String PASSWORD_LENTH_NOT_ENOUGH = "A0121";

// 自定义开始
  ///密码强度不够
  static const String PASSWORD_NOT_STRONG = "A0122";

  ///首次登录修改密码
  static const String FIRST_LOGIN_UPDATE_PASSWORD = "A0124";

  ///新密码两次是否一致
  static const String NEW_PASSWORD_TWICE_NOT_MATCH = "A0125";
// 自定义结束

  ///密码过期
  static const String PASSWORD_EXPIRED = "A0123";

  ///校验码输入错误
  static const String CHECKCODE_INPUT_ERROR = "A0130";

  ///短信校验码输入错误
  static const String SHORTMESSAGE_CHECKCODE_ERROR = "A0131";

  ///邮件校验码输入错误
  static const String EMAIL_CHECKCODE_ERROR = "A0132";

  ///语音校验码输入错误
  static const String VOICE_CHECKCODE_ERROR = "A0133";

  ///用户证件异常
  static const String USERID_IS_ABNORMAL = "A0140";

  ///用户证件类型未选择
  static const String USERID_TYPE_NOT_SELECTED = "A0141";

  ///大陆身份证编号校验非法
  static const String IDCARD_NUMBER_ILLEGAL = "A0142";

  ///护照编号校验非法
  static const String PASSPORT_NUMBER_ILLEGAL = "A0143";

  ///军官证编号校验非法
  static const String OFFICER_NUMBER_ILLEGAL = "A0144";

  ///用户基本信息校验失败
  static const String USER_BASIC_INFO_VERTIFY_FAIL = "A0150";

  ///手机格式校验失败
  static const String PHONE_FORMAT_CHECK_FAIL = "A0151";

  ///邮件发送失败
  static const String EMAIL_SENDING_FAILED = "A0152";

  ///邮箱格式校验失败
  static const String EMAIL_FORMAT_CHECK_FAIL = "A0153";

  // 自定义开始

  ///用户登陆异常
  static const String USER_LOGIN_EXCEPTION = "A0200";

  ///用户账户不存在
  static const String USERNAME_NOT_EXISTS = "A0201";

  ///用户账户被冻结
  static const String ACCOUNT_LOCKED = "A0202";

  ///用户账户已作废
  static const String ACCOUNT_DISABLED = "A0203";

  ///用户密码错误
  static const String PASSWORD_NOT_CORRECT = "A0210";

  ///用户输入密码次数超限
  static const String USER_INPUT_PWD_COUNT_EXCEED_LIMIT = "A0211";

  ///用户身份校验失败
  static const String IDENTITY_CHECK_FAIL = "A0220";

  ///用户指纹识别失败
  static const String USER_FINGERPRINT_FAIL = "A0221";

  ///用户面容识别失败
  static const String USER_FACEID_FAIL = "A0222";

  ///用户未获得第三方登陆授权
  static const String NO_ACQUIRE_THIRD_PARTY = "A0223";

  ///用户登陆已过期
  static const String USERNAME_LOGIN_EXPIRED = "A0230";

  ///用户验证码错误
  static const String VERIFICATION_CODE_ERROR = "A0240";

  ///用户验证码尝试次数超限
  static const String USER_VERTIFY_CODE_COUNT_EXCEED_LIMIT = "A0241";

  ///访问权限异常
  static const String ACCESS_RIGHT_EXCEPTION = "A0300";

  ///访问未授权
  static const String ACCESS_NOT_AUTHORIZATION = "A0301";

  ///正在授权中
  static const String AUTHORIZATING = "A0302";

  ///用户授权申请被拒绝
  static const String AUTHORIZATION_REJECTED = "A0303";

  ///因访问对象隐私设置被拦截
  static const String BLOCKED_DUETO_PRIVACY_SETTING = "A0310";

  ///无权限使用 API
  static const String NO_RIGHTS_ACCESS = "A0312";

  ///用户访问被拦截
  static const String ACCESS_INTERCEPT = "A0320";

  ///黑名单用户
  static const String BLACKLIST_USER = "A0321";

  ///账号被冻结
  static const String ACCOUT_FROZEN = "A0322";

  ///非法 IP 地址
  static const String ILLEGAL_IP_ADDRESS = "A0323";

  ///网关访问受限
  static const String GATEWAY_ACCESS_LIMIT = "A0324";

  ///地域黑名单
  static const String REGIONAL_BLACKLIST = "A0325";

  ///服务欠费
  static const String SERVICE_ARRERARS = "A0330";

  ///用户签名异常
  static const String USER_SIGN_EXCEPTION = "A0340";

  ///RSA 签名错误
  static const String RSA_SIGN_ERROR = "A0341";

  ///用户请求参数错误
  static const String REQUEST_PARAM_ERROR = "A0400";

  ///包含非法恶意跳转链接
  static const String URL_ERROR = "A0401";

  ///无效的用户输入
  static const String INVALID_USER_INPUT = "A0402";

  ///请求必填参数为空
  static const String REQUEST_PARAM_IS_NULL = "A0410";

  ///用户订单号为空
  static const String USER_ORDER_NUMBER_IS_NULL = "A0411";

  ///订购数量为空
  static const String ORDER_QUANTITY_IS_NULL = "A0412";

  ///缺少时间戳参数
  static const String MISS_TIMESTAMP_PARAM = "A0413";

  ///非法的时间戳参数
  static const String ILLEGAL_TIMESTAMP_PARAM = "A0414";

  ///请求参数值超出允许的范围
  static const String REQUEST_PARAMETER_VALUE_OUT_OF_ALLOWED_RANGE = "A0420";

  ///参数格式不匹配
  static const String PARAMETER_FORMAT_MISMATCH = "A0421";

  ///地址不在服务范围
  static const String ADDRESS_NOT_IN_SERVICE = "A0422";

  ///时间不在服务范围
  static const String TIME_NOT_IN_SERVICE = "A0423";

  ///金额超出限制
  static const String AMOUNT_EXCEEDS_LIMIT = "A0424";

  ///数量超出限制
  static const String QUANTITY_EXCEEDS_LIMIT = "A0425";

  ///请求批量处理总个数超出限制
  static const String BATCH_REQUEST_COUNT_EXCEEDS_LIMIT = "A0426";

  ///请求 JSON 解析失败
  static const String REQUEST_JSON_PARSE_FAIL = "A0427";

  ///用户输入内容非法
  static const String USER_INPUT_IS_ILLEGAL = "A0430";

  ///包含违禁敏感词
  static const String CONTAINS_SENSITIVE_WORDS = "A0431";

  ///图片包含违禁信息
  static const String IMAGE_CONTAINS_SENSITIVE_WORDS = "A0432";

  ///文件侵犯版权
  static const String FILE_INFRINGES_COPYRIGHT = "A0433";

  ///用户操作异常
  static const String USER_OPERATE_EXCEPTION = "A0440";

  ///用户支付超时
  static const String USER_PAYMENT_TIMEOUT = "A0441";

  ///确认订单超时
  static const String CONFIRM_ORDER_TIMEOUT = "A0442";

  ///订单已关闭
  static const String ORDER_CLOSE = "A0443";

  ///用户请求服务异常
  static const String REQUEST_SERVICE_EXCEPTION = "A0500";

  ///请求次数超出限制
  static const String REQUEST_COUNT_EXCEEDS_LIMIT = "A0501";

  ///请求并发数超出限制
  static const String REQUEST_CONCURRENT_COUNT_EXCEEDS_LIMIT = "A0502";

  ///用户操作请等待
  static const String USER_OPERATE_WAIT = "A0503";

  ///WebSocket 连接异常
  static const String WEBSOCKET_LINK_EXCEPTION = "A0504";

  ///WebSocket 连接断开
  static const String WEBSOCKET_DISCONNECT = "A0505";

  ///用户重复请求
  static const String USER_REPEAT_REQUEST = "A0506";

  ///用户资源异常
  static const String USER_RESOURCE_EXCEPTION = "A0600";

  ///账户余额不足
  static const String INSUFFCIENT_BALANCE = "A0601";

  ///用户磁盘空间不足
  static const String INSUFFICIENT_USER_DISK_SPACE = "A0602";

  ///用户内存空间不足
  static const String INSUFFICIENT_USER_MEMORY_SPACE = "A0603";

  ///用户 OSS 容量不足
  static const String INSUFFICIENT_USER_OSS_SPACE = "A0604";

  ///用户配额已用光
  static const String USER_QUOTA_HAS_USEUP = "A0605";

  ///用户上传文件异常
  static const String USER_UPLOAD_FILE_EXCEPTION = "A0700";

  ///用户上传文件类型不匹配
  static const String USER_UPLOAD_FILETYPE_NOT_MATCH = "A0701";

  ///用户上传文件太大
  static const String USER_UPLOAD_FILE_TOO_ENOUGH = "A0702";

  ///用户上传图片太大
  static const String USER_UPLOAD_IMAGE_TOO_ENOUGH = "A0703";

  ///用户上传视频太大
  static const String USER_UPLOAD_VIDEO_TOO_ENOUGH = "A0704";

  ///用户上传压缩文件太大
  static const String USER_UPLOAD_ZIP_TOO_ENOUGH = "A0705";

  ///用户当前版本异常
  static const String USER_CURRENT_VERSION_EXCEPTION = "A0800";

  ///用户安装版本与系统不匹配
  static const String USER_INSTALL_VERSION_NOT_MATCH_SYSTEM = "A0801";

  ///用户安装版本过低
  static const String USER_INSTALL_VERSION_LOW = "A0802";

  ///用户安装版本过高
  static const String USER_INSTALL_VERSION_HIGH = "A0803";

  ///用户安装版本已过期
  static const String USER_INSTALL_VERSION_HAS_EXPIRED = "A0804";

  ///用户 API 请求版本不匹配
  static const String USER_API_REQUEST_NOT_MATCH = "A0805";

  ///用户 API 请求版本过高
  static const String USER_API_REQUEST_VERSION_HIGH = "A0806";

  ///用户 API 请求版本过低
  static const String USER_API_REQUEST_VERSION_LOW = "A0807";

  ///用户隐私未授权
  static const String USER_PRIVACY_UNAUTHORIZED = "A0900";

  ///用户隐私未签署
  static const String USER_PRIVACY_NOT_SIGN = "A0901";

  ///用户相机未授权
  static const String USER_CAMERA_UNAUTHORIZED = "A0903";

  ///用户图片库未授权
  static const String USER_IMAGE_UNAUTHORIZED = "A0904";

  ///用户文件未授权
  static const String USER_FILE_UNAUTHORIZED = "A0905";

  ///用户位置信息未授权
  static const String USER_LOCATION_UNAUTHORIZED = "A0906";

  ///用户通讯录未授权
  static const String USER_ADDRESSBOOK_UNAUTHORIZED = "A0907";

  ///用户设备异常
  static const String USER_DEVICE_EXCEPTION = "A1000";

  ///用户相机异常
  static const String USER_CAMERA_EXCEPTION = "A1001";

  ///用户麦克风异常
  static const String USER_MICROPHONE_EXCEPTION = "A1002";

  ///用户听筒异常
  static const String USER_EARPIECE_EXCEPTION = "A1003";

  ///用户扬声器异常
  static const String USER_SPEACKER_EXCEPTION = "A1004";

  ///用户 GPS 定位异常
  static const String USER_GPS_EXCEPTION = "A1005";

  ///系统执行出错
  static const String SYSTEM_PROCESS_ERROR = "B0001";

  ///系统执行超时
  static const String SYSTEM_PROCESS_TIMEOUT = "B0100";

  ///动态口令错误
  static const String VERIFICATION_CODE_ERROR_DYNAMIC = 'A0243';

  ///动态口令失效(一密一用)
  static const String DYNAMIC_PASSWORD_FAILURE = 'A0129';

  ///用户临时被锁定
  static const String USERNAME_TEMP_LOCK  = 'A0135';

  ///用户永久被锁定
  static const String USERNAME_PERMANENT_LOCK = 'A0127';

  ///动态口令锁定
  static const String TOTP_LOCK = 'A0114';

  ///已在其他设备登录
  static const String OTHER_EQUIPMENT = 'A0204';

  ///授权已过期
  static const String AUTHORIZATION_EXPIRED = "A0311";

  ///未知错误
  static const String UNKNOWN_ERROR = 'S0500';


}
