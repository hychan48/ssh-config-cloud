import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "SSH Config Cloud",
  description: "KVM Cloud-Init Hyper-V",
  base:"/ssh-config-cloud/",
  srcDir: './src',//relative to the package.json vitepress dev <dir>
  lang: 'en-ca',
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Examples', link: '/markdown-examples' }
    ],

    sidebar: [
      {
        text: 'Examples',
        items: [
          { text: 'Markdown Examples', link: '/markdown-examples' },
          { text: 'Runtime API Examples', link: '/api-examples' }
        ]
      }
    ],

    //add better search. https://vitepress.dev/reference/default-theme-search#local-search
    search: {
      provider: 'local'
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/hychan48/ssh-config-cloud' }
    ],
    markdown:{
      //https://vitepress.dev/reference/site-config#markdown
      lineNumbers: true,
      space_size: 2,//not sure if this works
    }
  }
})
