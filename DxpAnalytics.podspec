Pod::Spec.new do |spec|
  spec.name         = "DxpAnalytics"
  spec.version      = "1.0.1"
  spec.summary      = "DXP Analytics"
  spec.description  = "DXP Analytics SDK"
  spec.homepage     = "https://github.com/HelloGitHub123/DxpAnalytics"
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  spec.author        = { "李标" => "li.biao3@iwhalecloud.com" }

  spec.platform      = :ios, "12.0"
  spec.swift_versions = ["5.0"]

  spec.source = {
    :git => "https://github.com/HelloGitHub123/DxpAnalytics.git",
    :tag => spec.version.to_s
  }

  # 与根目录、子目录下的源码都匹配（避免仅一层目录时 glob 边界问题）
  spec.source_files = [
    "DxpAnalytics/*.{h,m,swift}",
    "DxpAnalytics/**/*.{h,m,swift}"
  ]

  spec.module_name = "DxpAnalytics"
  spec.requires_arc = true

  # 与依赖 DXPAnalyticsLib（常为静态/预编译）时 trunk / spec lint 更一致，减少 transitive static binary 报错
  spec.static_framework = true

  spec.frameworks = "Foundation", "UIKit"

  spec.pod_target_xcconfig = {
    "DEFINES_MODULE" => "YES",
    "CLANG_ENABLE_MODULES" => "YES"
  }

  # 建议与 DXPAnalyticsLib 发版版本对齐，例如: '~> 1.0'
  spec.dependency "DXPAnalyticsLib"
end
