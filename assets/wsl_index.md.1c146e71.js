import{_ as s,o as a,c as l,V as n}from"./chunks/framework.9f4d38c9.js";const d=JSON.parse('{"title":"WSL 2","description":"","frontmatter":{},"headers":[],"relativePath":"wsl/index.md","filePath":"wsl/index.md"}'),e={name:"wsl/index.md"},o=n(`<h1 id="wsl-2" tabindex="-1">WSL 2 <a class="header-anchor" href="#wsl-2" aria-label="Permalink to &quot;WSL 2&quot;">​</a></h1><h2 id="common" tabindex="-1">Common <a class="header-anchor" href="#common" aria-label="Permalink to &quot;Common&quot;">​</a></h2><div class="vp-code-group"><div class="tabs"><input type="radio" name="group-f8ec-" id="tab-wuVJvYT" checked="checked"><label for="tab-wuVJvYT">main</label><input type="radio" name="group-f8ec-" id="tab-WXNR4Rg"><label for="tab-WXNR4Rg">misc</label></div><div class="blocks"><div class="language-powershell active"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">list </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">verbose</span></span>
<span class="line"><span style="color:#676E95;font-style:italic;"># root user can access Windows</span></span>
<span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">distribution Debian </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">user root</span></span>
<span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">distribution Ubuntu</span><span style="color:#89DDFF;">-</span><span style="color:#F78C6C;">22.04</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">user root</span></span></code></pre></div><div class="language-powershell"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">distribution Debian </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">user deb</span></span>
<span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">distribution Ubuntu</span><span style="color:#89DDFF;">-</span><span style="color:#F78C6C;">22.04</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">user ubuntu</span></span></code></pre></div></div></div><h2 id="exec-tree" tabindex="-1">Exec - Tree <a class="header-anchor" href="#exec-tree" aria-label="Permalink to &quot;Exec - Tree&quot;">​</a></h2><div class="language-powershell"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;"> tree </span><span style="color:#89DDFF;">.</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">-</span><span style="color:#A6ACCD;">L </span><span style="color:#F78C6C;">1</span></span></code></pre></div><details class="details custom-block"><summary>Details</summary><div class="language-powershell"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;"> exec</span><span style="color:#89DDFF;">,</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">-</span><span style="color:#A6ACCD;">e </span><span style="color:#89DDFF;">&lt;</span><span style="color:#A6ACCD;">CommandLine</span><span style="color:#89DDFF;">&gt;</span><span style="color:#A6ACCD;"> Execute without </span><span style="color:#89DDFF;">$</span><span style="color:#A6ACCD;">SHELL</span></span>
<span class="line"><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;"> Pass the remaining command line as is.</span></span>
<span class="line"><span style="color:#676E95;font-style:italic;"># %LOCALAPPDATA%\\Packages\\</span></span>
<span class="line"><span style="color:#676E95;font-style:italic;"># WSL Set Default</span></span>
<span class="line"><span style="color:#A6ACCD;">wsl </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">setdefault docker</span><span style="color:#89DDFF;">-</span><span style="color:#A6ACCD;">desktop</span><span style="color:#89DDFF;">-</span><span style="color:#A6ACCD;">data</span></span>
<span class="line"><span style="color:#A6ACCD;">wsl </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">setdefault Debian</span></span>
<span class="line"><span style="color:#A6ACCD;">wsl </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">setdefault Ubuntu</span><span style="color:#89DDFF;">-</span><span style="color:#F78C6C;">22.04</span></span>
<span class="line"></span>
<span class="line"><span style="color:#676E95;font-style:italic;"># Debian Default user</span></span>
<span class="line"><span style="color:#82AAFF;">debian.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">help</span></span>
<span class="line"><span style="color:#82AAFF;">debian.exe</span><span style="color:#A6ACCD;"> config </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">default</span><span style="color:#89DDFF;">-</span><span style="color:#A6ACCD;">user root</span></span>
<span class="line"><span style="color:#82AAFF;">debian.exe</span><span style="color:#A6ACCD;"> config </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">default</span><span style="color:#89DDFF;">-</span><span style="color:#A6ACCD;">user deb</span></span></code></pre></div></details><h2 id="sshd-restart" tabindex="-1">SSHD Restart <a class="header-anchor" href="#sshd-restart" aria-label="Permalink to &quot;SSHD Restart&quot;">​</a></h2><div class="language-bash"><button title="Copy Code" class="copy"></button><span class="lang">bash</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#676E95;font-style:italic;">#!/bin/bash - inside WSL Ubuntu</span></span>
<span class="line"><span style="color:#FFCB6B;">/etc/init.d/ssh</span><span style="color:#A6ACCD;"> </span><span style="color:#C3E88D;">restart</span></span></code></pre></div><h2 id="shutdown-delete" tabindex="-1">Shutdown / Delete <a class="header-anchor" href="#shutdown-delete" aria-label="Permalink to &quot;Shutdown / Delete&quot;">​</a></h2><div class="vp-code-group"><div class="tabs"><input type="radio" name="group-Z_gun" id="tab-pFgcT4g" checked="checked"><label for="tab-pFgcT4g">shutdown</label><input type="radio" name="group-Z_gun" id="tab-y8_TbLX"><label for="tab-y8_TbLX">force shutdown</label><input type="radio" name="group-Z_gun" id="tab-h7IyK9Y"><label for="tab-h7IyK9Y">unregister-undefine-remove</label></div><div class="blocks"><div class="language-powershell active"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">shutdown ub22</span></span>
<span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">shutdown </span><span style="color:#676E95;font-style:italic;">#all</span></span></code></pre></div><div class="language-powershell"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">terminate ub22</span></span></code></pre></div><div class="language-powershell"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">unregister ub22 </span><span style="color:#676E95;font-style:italic;"># removes the vmdx...</span></span></code></pre></div></div></div><h2 id="vm-tools" tabindex="-1">VM Tools <a class="header-anchor" href="#vm-tools" aria-label="Permalink to &quot;VM Tools&quot;">​</a></h2><ul><li>convert img to vhdx</li><li>virt-customize etc.</li><li>qemu-guest-agent installer</li></ul><h2 id="misc" tabindex="-1">Misc <a class="header-anchor" href="#misc" aria-label="Permalink to &quot;Misc&quot;">​</a></h2><div class="vp-code-group"><div class="tabs"><input type="radio" name="group-sRj95" id="tab-vez8xK1" checked="checked"><label for="tab-vez8xK1">powershell</label><input type="radio" name="group-sRj95" id="tab-Liy4pxs"><label for="tab-Liy4pxs">name-state-version.log</label><input type="radio" name="group-sRj95" id="tab-t6o8XVS"><label for="tab-t6o8XVS">powershell</label><input type="radio" name="group-sRj95" id="tab-x-clYAT"><label for="tab-x-clYAT">powershell</label></div><div class="blocks"><div class="language-powershell active"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">list </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">verbose</span></span></code></pre></div><div class="language-txt"><button title="Copy Code" class="copy"></button><span class="lang">txt</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#A6ACCD;">NAME                   STATE           VERSION</span></span>
<span class="line"><span style="color:#A6ACCD;">* docker-desktop-data    Stopped         2</span></span>
<span class="line"><span style="color:#A6ACCD;">  Ubuntu-22.04           Stopped         2</span></span>
<span class="line"><span style="color:#A6ACCD;">  Debian                 Stopped         2</span></span></code></pre></div><div class="language-powershell"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">list</span></span></code></pre></div><div class="language-powershell"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">list </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">all</span></span></code></pre></div></div></div><h1 id="maybe-rm" tabindex="-1">maybe rm... <a class="header-anchor" href="#maybe-rm" aria-label="Permalink to &quot;maybe rm...&quot;">​</a></h1><p>wsl.exe --import ub_clone C:\\Users\\hoyachan\\ub_clone ub22.bak.tar wsl.exe --import ub_clone1 C:\\Users\\hoyachan\\ub_clone1 ub22.bak.tar</p><h2 id="duplciate-wsl" tabindex="-1">Duplciate WSL <a class="header-anchor" href="#duplciate-wsl" aria-label="Permalink to &quot;Duplciate WSL&quot;">​</a></h2><div class="language-powershell"><button title="Copy Code" class="copy"></button><span class="lang">powershell</span><pre class="shiki material-theme-palenight"><code><span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">install </span><span style="color:#89DDFF;">&#39;</span><span style="color:#C3E88D;">Ubuntu-22.04</span><span style="color:#89DDFF;">&#39;</span></span>
<span class="line"></span>
<span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">export </span><span style="color:#89DDFF;">&#39;</span><span style="color:#C3E88D;">Ubuntu-22.04</span><span style="color:#89DDFF;">&#39;</span><span style="color:#A6ACCD;"> ub22.tar</span></span>
<span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">import ub22</span><span style="color:#89DDFF;">-</span><span style="color:#F78C6C;">1</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">$</span><span style="color:#A6ACCD;">HOME</span><span style="color:#89DDFF;">/</span><span style="color:#A6ACCD;">ub22</span><span style="color:#89DDFF;">-</span><span style="color:#F78C6C;">1</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">&quot;</span><span style="color:#C3E88D;">ub22.tar</span><span style="color:#89DDFF;">&quot;</span></span>
<span class="line"></span>
<span class="line"></span>
<span class="line"><span style="color:#676E95;font-style:italic;"># vhdx</span></span>
<span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">shutdown</span></span>
<span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">shutdown ub22</span><span style="color:#89DDFF;">-</span><span style="color:#F78C6C;">1</span></span>
<span class="line"><span style="color:#82AAFF;">wsl.exe</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">export ub22</span><span style="color:#89DDFF;">-</span><span style="color:#F78C6C;">1</span><span style="color:#A6ACCD;"> </span><span style="color:#89DDFF;">--</span><span style="color:#A6ACCD;">vhd ub22</span><span style="color:#89DDFF;">-</span><span style="color:#F78C6C;">1.</span><span style="color:#A6ACCD;">vhdx</span></span>
<span class="line"></span>
<span class="line"><span style="color:#676E95;font-style:italic;"># misc</span></span>
<span class="line"><span style="color:#82AAFF;">netsh.exe</span><span style="color:#A6ACCD;"> winsock reset </span><span style="color:#676E95;font-style:italic;"># get stuck sometimes</span></span></code></pre></div><h2 id="nt-to-wsl-exe-posix-mount-path" tabindex="-1">NT to wsl.exe Posix Mount Path <a class="header-anchor" href="#nt-to-wsl-exe-posix-mount-path" aria-label="Permalink to &quot;NT to wsl.exe Posix Mount Path&quot;">​</a></h2><ul><li><a href="https://codeforwings.github.io/nuxt3-win32-posix-path/" target="_blank" rel="noreferrer">win32-posix-path util</a></li><li>cygwin</li></ul>`,20),p=[o];function t(c,r,i,y,D,A){return a(),l("div",null,p)}const F=s(e,[["render",t]]);export{d as __pageData,F as default};
