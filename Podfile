platform :ios, '7.0'

pod 'Masonry' # 使用纯代码进行Auto Layout.
pod 'SDWebImage' # 异步图片加载.
pod 'AFNetworking' # 网络请求.
pod 'MJExtension' # JSON自动转为Model.
pod 'MJRefresh' # 添加上拉加载更多与下拉刷新功能.
pod 'MBProgressHUD' # 进度提示.
pod 'ReactiveCocoa' # RAC,一个支持响应式编程的库.
pod 'pop' # POP,动画库.
pod 'AFNetworking-RACExtensions' # 使AFN支持RAC模式.
pod 'Ono' # XML 解析
pod 'Mantle' # JSON <==> Model
pod 'Aspects' # AOP
pod 'DateTools' # 完整的日期工具库
pod 'Objection', '1.6.1' # 依赖注入.
pod 'JSPatch' # 在线更新应用.
pod 'FXForms' # 自动生成表单
pod 'PINCache' # 缓存库.

# Depending on how your project is organized, your node_modules directory may be
# somewhere else; tell CocoaPods where you've installed react-native from npm
pod 'React', :path => './node_modules/react-native', :subspecs => [
'Core',
'RCTImage',
'RCTNetwork',
'RCTText',
'RCTWebSocket',
# Add any other subspecs you want to use in your project
]

target :iOS122Tests, :exclusive => true do
    pod 'Kiwi'
end