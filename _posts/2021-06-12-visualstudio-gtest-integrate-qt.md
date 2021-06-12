---
layout: post
title: Visual Studio测试工具集成GoogleTest和Qt
---

Visual Studio 的测试管理工具虽然集成了 Google Test 测试框架，但缺少 QtTest 测试框架的支持，所以需要在 Google Test 集成 Qt 框架完成单元测试。

## 背景介绍

因为代码中不免需要编写单元测试，而且可能一个 VC 项目中带有若干个测试用例，这时难免有运行调试其中一个测试用例。
虽然 Visual Studio 本身有测试管理工具（Test Explorer），但目前官方维护和支持的测试框架[^vs2019-cpptest]只有 Google Test 、Boost Test 和 MS CppUnit Test Framework。
所以，采用简单的解决方案是在 Google Test 测试框架基础上，使其支持 Qt 框架。

## 问题描述

1. 如何让 Google Test 运行在 Qt 的事件循环中？
2. 如何使 Visual Studio 的测试管理工具（环境变量）能正常运行？

## 测试环境

* Visual Studio 2019 Community
* Test Adapter for Google Test[^vs2019-gtest]
* Qt VS Tools[^vs2019-qtvstools]
* Qt 5.15.2 ( msvc2019_64 )

## 创建项目

创建“__Qt Core Application__”项目，在 __Qt Modules__ 中选择 __Core__ 和 __Test__。

完成项目创建后，右键 __Manage NuGet Packages...__，搜索并引入 GoogleTest 测试框架，NuGet 包名 是 `Microsoft.googletest.v140.windesktop.msvcstl.static.rt-dyn`。

右键项目“__Properties__ > __Referenced Packages__ > __Google Test__”，设置 `Use Google Test's main Function` 为 `No`。因为我们需要手动编写 `main` 函数，以便 Google Test 能够正常启动 Qt 事件循环。

### 创建简单的测试启动类

修改 `main.cpp`，使 Google Test 运行在事件循环中。

```cpp
int main(int argc, char* argv[])
{
	QCoreApplication a(argc, argv);

	::testing::InitGoogleTest(&argc, argv);
	QTimer::singleShot(0, []() { QCoreApplication::exit(RUN_ALL_TESTS()); });

	return a.exec();
}
```

### 编写测试单元

结合 QtTest [^qttest-testqstring]简单写了 `QString::toUpper` 方法的单元测试。

```cpp
namespace QStringTests
{
	TEST(toUpper, AllLower)
	{
		QString string = "hello";
		EXPECT_EQ("HELLO", string.toUpper());
	}

	TEST(toUpper, Mixed)
	{
		QString string = "Hello";
		EXPECT_EQ("HELLO", string.toUpper());
	}

	TEST(toUpper, AllUpper)
	{
		QString string = "HELLO";
		EXPECT_EQ("HELLo", string.toUpper()); // failed
	}
}
```

编译运行后，可以看到类似的运行结果。

```log
[==========] Running 3 tests from 1 test case.
[----------] Global test environment set-up.
[----------] 3 tests from toUpper
[ RUN      ] toUpper.AllLower
[       OK ] toUpper.AllLower (0 ms)
[ RUN      ] toUpper.Mixed
[       OK ] toUpper.Mixed (0 ms)
[ RUN      ] toUpper.AllUpper
D:\repos\TestQString\TestQString.cpp(21): error: Expected equality of these values:
  "HELLo"
    Which is: 00007FF6978C7A58
  string.toUpper()
    Which is: { 2-byte object <48-00>, 2-byte object <45-00>, 2-byte object <4C-00>, 2-byte object <4C-00>, 2-byte object <4F-00> }
[  FAILED  ] toUpper.AllUpper (2 ms)
[----------] 3 tests from toUpper (5 ms total)

[----------] Global test environment tear-down
[==========] 3 tests from 1 test case ran. (8 ms total)
[  PASSED  ] 2 tests.
[  FAILED  ] 1 test, listed below:
[  FAILED  ] toUpper.AllUpper

 1 FAILED TEST

D:\repos\TestQString\x64\Debug\TestQString.exe (process 6740) exited with code 1.
```

## 扫描测试用例

打开菜单“__View__ > __Test Explorer__”，会多出测定管理工具，但是执行扫描不出意外会出现错误，因为扫描程序运行其实没有设置 Qt 的环境变量。

### 设置单元测试运行环境

Visual Sutdio 测试工具按照项目配置运行环境[^vs2019-runsettings]。

在当前项目目录下创建文件 `Qt.x64.runsettings`。

```xml
<?xml version="1.0" encoding="utf-8"?>
<RunSettings>
  <RunConfiguration>
    <EnvironmentVariables>
      <PATH>%PATH%;C:/Qt/5.15.2/msvc2019_64/bin</PATH>
    </EnvironmentVariables>
  </RunConfiguration>
</RunSettings>
```

卸载项目（Unload），并编辑项目，添加属性（__PropertyGroup__）。

```xml
<PropertyGroup>
    <RunSettingsFilePath>$(MSBuildProjectDirectory)\Qt.$(Platform).runsettings</RunSettingsFilePath>
</PropertyGroup>
```

重新打开项目，并且 __Rebuild__ 后，可以在 __Test Explorer__ 窗口中看到刚才声明的单元测试列表，并且可以针对若干个特定单元进行运行测试。

### 配置T4模板文件

通过创建 T4 模板文件[^vs2019-t4template] 来解决 `*.runsettings` 的 Qt 固定路径写法存在问题，以此方便不同 Qt 环境切换。

重命名 `Qt.x64.runsettings` 为 `Qt.runsettings.tt`，并修改文件内容。

```cs
<#@ template language="c#" hostspecific="true" #>
<#@ output extension=".runsettings" #>
<#@ parameter type="System.String" name="QtDllPath" #>
<?xml version="1.0" encoding="utf-8"?>
<RunSettings>
  <RunConfiguration>
    <EnvironmentVariables>
      <PATH>%PATH%;<#= QtDllPath #></PATH>
    </EnvironmentVariables>
  </RunConfiguration>
</RunSettings>
```

卸载项目配置 T4 模板构建任务，编辑项目文件内容。

```diff
-   <None Include="Qt.runsettings.tt">
  </ItemGroup>
+ <ItemGroup>
+   <None Include="Qt.runsettings.tt">
+     <Generator>TextTemplatingFileGenerator</Generator>
+     <OutputFileName>$(MSBuildProjectDirectory)\Qt.$(Platform).runsettings</OutputFileName>
+   </None>
+   <T4ParameterValues Include="QtDllPath">
+     <Value>$(QtDllPath)</Value>
+   </T4ParameterValues>
+ </ItemGroup>
```

```diff
  <PropertyGroup>
    <RunSettingsFilePath>$(MSBuildProjectDirectory)\Qt.$(Platform).runsettings</RunSettingsFilePath>
+   <TransformOnBuild>true</TransformOnBuild>
  </PropertyGroup>
+ <Import Project="$(MSBuildExtensionsPath32)\Microsoft\VisualStudio\v$(VisualStudioVersion)\TextTemplating\Microsoft.TextTemplating.targets" />
```

打开项目，执行 __Rebuild__，如果看到如下编译输出，并且当前项目出现 `Qt.x64.runsettings`，代表生成成功。

```log
....
1>Transforming template Qt.runsettings.tt...
....
```

## 运行截图

![Test Explorer Results](/img/2021-06-12.png)

[^vs2019-cpptest]: https://docs.microsoft.com/zh-cn/visualstudio/test/writing-unit-tests-for-c-cpp?view=vs-2019
[^vs2019-gtest]: https://docs.microsoft.com/zh-cn/visualstudio/test/how-to-use-google-test-for-cpp?view=vs-2019
[^vs2019-qtvstools]: https://marketplace.visualstudio.com/items?itemName=TheQtCompany.QtVisualStudioTools2019
[^qttest-testqstring]: https://doc.qt.io/qt-5.15/qttestlib-tutorial2-example.html
[^vs2019-runsettings]: https://docs.microsoft.com/zh-cn/visualstudio/test/configure-unit-tests-by-using-a-dot-runsettings-file?view=vs-2019
[^vs2019-t4template]: https://docs.microsoft.com/en-us/visualstudio/modeling/writing-a-t4-text-template?view=vs-2019