import { defineConfig } from 'vitepress'

import { fileURLToPath } from 'url';
const vite = {
    define: {
      // HOME:'c:/Users/Jason',
      'process.env': {
        VITE_HOME:'c:/Users/Jason',
        VITEPRESS_HOME:'c:/Users/Jason',
      }
    },
    resolve: {
      alias: {
        // https://vitejs.dev/config/shared-options.html#resolve-alias
        //https://nodejs.dev/en/api/v18/packages/#subpath-imports
        '##': fileURLToPath(new URL('../..', import.meta.url)),//.vitepress
        '#src': fileURLToPath(new URL('../../src', import.meta.url)),//doc src?
        '#dsrc': fileURLToPath(new URL('../src', import.meta.url)),//doc src?
        '#docs': fileURLToPath(new URL('../', import.meta.url)),
      },
    }
};
// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "SSH Config Cloud",
  vite,
  description: "KVM Cloud-Init Hyper-V",
  base:"/ssh-config-cloud/",
  srcDir: './src',//relative to the package.json vitepress dev <dir>
  lang: 'en-ca',
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Examples', link: '/vitePress/' } //need landing page
    ],

    sidebar: [
      //try plugin again todo
      {
        text: 'WSL',
        items: [
          { text: 'WSL 2', link: '/wsl/index' },
        ]
      },
      {
        text: 'SSH',
        items: [
          { text: 'SSH', link: '/ssh/index' },
          { text: 'Rsync', link: '/ssh/readme_scp_rsync' },
        ]
      },
      {
        text: 'VitePress Examples',
        items: [
          { text: 'Developer Notes', link: '/vitePress/' },
          { text: 'Markdown Examples', link: '/vitePress/markdown-examples' },
          { text: 'Runtime API Examples', link: '/vitePress/api-examples' }
        ]
      },


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
