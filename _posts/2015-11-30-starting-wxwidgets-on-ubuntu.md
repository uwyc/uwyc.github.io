---
layout: post
title: "在Ubuntu上编译使用wxWidgests"
author: 吴彦昌
data: 2015-11-30 17:49 +8:00
tags: ['ubuntu', 'wxwidgets', 'c++', 'eclipse']
thread_key: 2015-11-30-starting-wxwidget-with-eclipse
---

[wxWidgets](https://wxwidgets.org/){:target="blank"}是一个跨平台的C++的GUI开发库，用来开发桌面应用程序的，具体就不加介绍了，详情的话可以看看官网的[Wiki](https://wiki.wxwidgets.org/Main_Page){:target="blank"}或是使用搜索引擎搜索相关介绍。这次主要讲讲，我第一次使用这个开发库遇见的问题，和一些简单的解决方法，特别是如何使用eclipse的IDE环境（注：如果不是硬性要装elipse，相信其他IDE比较适合，比如[Code::Blocks](http://codeblocks.org/){:target="blank"}或[Codelite](http://codelite.org/){:target="blank"}）。

> 为什么要用wxWidgets呢，这个原因，主要是自己学了C++无从使用有点不甘心，而且大学将近过了一大半了，现在连个简单的桌面应用程序都写不出，出去都不好意思说我是软工专业毕业的了 (／‵Д′)／~ ╧╧

在使用wxWidgets之前，还是先要安装这个开发库，这其中，有两个名词注意一下，一个是静态链接库以及动态链接库，这其中的区别，可以简单理解为，运行时，经动态链接库编译的也需要这个动态链接库，而静态的不需要，运行可执行文件即可（这里，我可能解释得不是很准确，给个比较好的[介绍链接](http://blog.csdn.net/chlele0105/article/details/23691147){:target="blank"}[^diff-lib]）。说了那么多，那么就开始编译安装wxWidgets了，在这里，我就不提供安装包或者包管理安装了，因为这些官网都有简单的介绍[^install]，主要还是讲一讲比较“折磨”的源代码安装。

我主要还是讲讲Ubuntu下的安装方式，Ubuntu就比较简单了，其实就三句命令，分别是**配置**、**编译**、**安装**，当然规范的源代码安装也是这样的，学好这个固然理解整个源代码安装的规范流程。

1. 首先是配置，这里官网有提供简单的[配置参数](https://wiki.wxwidgets.org/WxWidgets_Build_Configurations){:target="blank"}[^config]
{% highlight Bash %}
# 首先，解压从官网上下载的源代码，并在其目录下建立一个用来存放编译文件的目录
$ cd /path/to/wxWidgets
$ mkdir gtk-build
# 我在这个建立一个gtk-build的目录用来存放之后编译后的文件
$ cd gtk-build
$ ../Configure --enable-unicode --enable-monolithic --enable-debug
{% endhighlight %}
在这里，我简单介绍一下，一些配置信息，默认情况下，是生成动态链接库，可以使用参数`--disable-shared`取消，而生成单文件的参数`--enable-monolithic`只能在动态链接库的选项下执行，而`--enable-debug`是可以使用`Debug`的方式编译运行，而默认的安装目录实在`/usr/local/`下，修改参数`--prefix=/your/installation/path`即可，具体的其他参数，可参考`--help`或者官网。至于windows下的编译，我就提供一个[链接](http://blog.csdn.net/sxhelijian/article/details/26163791){:target="blank"}[^win-install]供大家参考（其实刚才那个官网提供的参数配置[^config]里也有介绍到windows的编译方式）

2. 接下来，就是编译了，做好上一步的话，编译就不是很难了，只需要在刚才那个`gtk-build`目录下执行一句命令`$ make`就可以了。对了，上一步配置检查的过程中会有缺少`gtk`依赖项的小错误，[解决方式](https://forums.wxwidgets.org/viewtopic.php?t=34891){:target="blank"}[^gtk-dev]：`sudo apt-get install libgtk2.0-dev`。

3. 安装，如果没有更改安装目录的话，安装至`/usr/local/`目录下，可能有权限问题，所以要在`gtk-build`执行`sudo make install`；如果是安装在非权限目录下，执行`make install`就可以了，但是这样会带来环境配置的问题，最好还是装在`/usr/local`，方便管理。

最后，就是如何在eclipse上使用该开发库了，自然，我是已经安装好了eclipse，至于如何在Ubuntu下安装elipse，就已经偏题了。先提供[官网的配置方法](https://wiki.wxwidgets.org/Eclipse){:target="blank"}，当然也是最正确的配置方式。

> 有人会问，eclipse编C程序是个坑，但是，我因为一些原因，要用到eclipse，且已经安装完CDT了，为什么不用呢，还要多下个软件，徒增内存（以上纯属个人意见，当然如果是为了更大的项目的话，在eclipse上编C的确不是很好的选择，但我们是学习嘛，就不用考虑那么多了嘛）。

打开eclipse，先建立一个C++项目（File->New->C++ Project），然后之后在这个项目上右键选择*Properties*，在`C/C++ Build -> Setting`设置里，有以下几个地方要设置。

![GCC C++ Compiler Setting]({{site.url}}/assets/2015-11-30-001.png)

C++编译设置里，在`Miscellaneous**->Others flags`后添加（\`wx-config --cxxflags\`），不要忘了（\`）这个符号。

![GCC C Compiler Setting]({{site.url}}/assets/2015-11-30-002.png)

C编译设置里，同理，加上（\`wx-config --cflags\`）。

![GCC C++ Linker Setting]({{site.url}}/assets/2015-11-30-003.png)

在C++的链接器设置中，在**Linker flags**中添加（\`wx-config --libs\`）

![GCC C++ Linker Setting]({{site.url}}/assets/2015-11-30-004.png)

将其**Command Line Pattern**中改为
{% highlight Bash %}
${COMMAND} ${OUTPUT_FLAG} ${OUTPUT_PREFIX} ${OUTPUT} ${INPUTS} ${FLAGS}
{% endhighlight %}

之后，建立一个`main.cpp`写入代码测试一下，发现缺少`libwx_gtk2u-3.0.so`文件，原来在运行的时候，系统没有添加`/usr/local/lib`下的运行库文件，所以在elipse的运行设置中添加这样一段即可。

![Run Configurations]({{site.url}}/assets/2015-11-30-005.png)

还有就是在编程的时候，没有自动填充，这是很头疼的事，eclipse提供了一个功能能够倒入头文件来建立自动填充的提示，虽然要另外安`Alt + /`实现，但也是足够了。具体还是看这个[解决方案](http://stackoverflow.com/questions/8209978/how-to-enable-code-completion-for-wxwidgets-in-eclipse-ide){:target="blank"}[^autocomplete]（如下图设置）。

![Paths and Symbols]({{site.url}}/assets/2015-11-30-006.png)

至于测试代码，我这里附上官网的`hello`源码

{% highlight C++ %}
// wxWidgets "Hello world" Program
// For compilers that support precompilation, includes "wx/wx.h".
#include <wx/wxprec.h>
#ifndef WX_PRECOMP
    #include <wx/wx.h>
#endif
class MyApp: public wxApp
{
public:
    virtual bool OnInit();
};
class MyFrame: public wxFrame
{
public:
    MyFrame(const wxString& title, const wxPoint& pos, const wxSize& size);
private:
    void OnHello(wxCommandEvent& event);
    void OnExit(wxCommandEvent& event);
    void OnAbout(wxCommandEvent& event);
    wxDECLARE_EVENT_TABLE();
};
enum
{
    ID_Hello = 1
};
wxBEGIN_EVENT_TABLE(MyFrame, wxFrame)
    EVT_MENU(ID_Hello,   MyFrame::OnHello)
    EVT_MENU(wxID_EXIT,  MyFrame::OnExit)
    EVT_MENU(wxID_ABOUT, MyFrame::OnAbout)
wxEND_EVENT_TABLE()
wxIMPLEMENT_APP(MyApp);
bool MyApp::OnInit()
{
    MyFrame *frame = new MyFrame( "Hello World", wxPoint(50, 50), wxSize(450, 340) );
    frame->Show( true );
    return true;
}
MyFrame::MyFrame(const wxString& title, const wxPoint& pos, const wxSize& size)
        : wxFrame(NULL, wxID_ANY, title, pos, size)
{
    wxMenu *menuFile = new wxMenu;
    menuFile->Append(ID_Hello, "&Hello...\tCtrl-H",
                     "Help string shown in status bar for this menu item");
    menuFile->AppendSeparator();
    menuFile->Append(wxID_EXIT);
    wxMenu *menuHelp = new wxMenu;
    menuHelp->Append(wxID_ABOUT);
    wxMenuBar *menuBar = new wxMenuBar;
    menuBar->Append( menuFile, "&File" );
    menuBar->Append( menuHelp, "&Help" );
    SetMenuBar( menuBar );
    CreateStatusBar();
    SetStatusText( "Welcome to wxWidgets!" );
}
void MyFrame::OnExit(wxCommandEvent& event)
{
    Close( true );
}
void MyFrame::OnAbout(wxCommandEvent& event)
{
    wxMessageBox( "This is a wxWidgets' Hello world sample",
                  "About Hello World", wxOK | wxICON_INFORMATION );
}
void MyFrame::OnHello(wxCommandEvent& event)
{
    wxLogMessage("Hello world from wxWidgets!");
}
{% endhighlight %}

另外，可能有一些朋友是使用windows的eclipse，在这里，附上另外一个人写的教程做[参考](http://my.oschina.net/uniquejava/blog/108692?fromerr=JtezGgRI){:target="blank"}

-----

[^diff-lib]: [Linux的.a、.so和.o文件 - chlele0105的专栏 - 博客频道 - CSDN.NET](http://blog.csdn.net/chlele0105/article/details/23691147){:target="blank"}

[^install]: [wxWidgets的各平台安装包下载](https://wxwidgets.org/downloads/){:target="blank"}

[^config]: [WxWidgets Build Configurations](https://wiki.wxwidgets.org/WxWidgets_Build_Configurations){:target="blank"}

[^win-install]: [wxWidgets初学者导引（2）——下载、安装wxWidgets - 迂者-贺利坚的专栏 - 博客频道 - CSDN.NET](http://blog.csdn.net/sxhelijian/article/details/26163791){:target="blank"}

[^gtk-dev]: [https://forums.wxwidgets.org/viewtopic.php?t=34891](https://forums.wxwidgets.org/viewtopic.php?t=34891){:target="blank"}

[^autocomplete]: [autocomplete - How to enable code completion for wxWidgets in Eclipse IDE - Stack Overflow](http://stackoverflow.com/questions/8209978/how-to-enable-code-completion-for-wxwidgets-in-eclipse-ide){:target="blank"}

[^win-eclipse-config]: [Eclipse CDT中运行wxWidgets实战](http://my.oschina.net/uniquejava/blog/108692?fromerr=JtezGgRI){:target="blank"}
