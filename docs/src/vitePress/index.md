---
editLink: true #requires config
lastUpdated: true

---
<script setup>
import {withBase} from 'vitepress'

import helloWorld from "#dsrc/components/hello-world.vue"
// import helloWorld from "%HOME%/VSCodeProjects/ssh-config-cloud/docs/src/components/hello-world.vue"
console.log(process.env.HOME);
// import helloWorld from "process.env.HOME/VSCodeProjects/ssh-config-cloud/docs/src/components/hello-world.vue"

</script>
```js-vue
process.env.VITE_HOME
process.env.VITEPRESS_HOME
```
process.env.VITE_HOME
process.env.VITEPRESS_HOME

# Developer Notes
<helloWorld />

:::code-group
```js-vue [js-vue]
base {{withBase('/')}}
```
```vue [v-pre]
base {{withBase('/')}}
```

[//]: # (* [Anchor Doesnt work]&#40;withBase&#40;'/ssh/ssh-docs.sh'&#41;&#41;)

:::

## Import
* `.vitepress`
* Use build to find the path. 
::: code-group
```js [right]
// within src
import helloWorld from "##/docs/src/components/hello-world.vue"
import helloWorld from "c:/Users/Public/Projects/ssh-config-cloud/docs/src/components/hello-world.vue"
import helloWorld from "#docs/src/components/hello-world.vue"
```
```js [wrong]
import helloWorld from "$HOME/Projects/ssh-config-cloud/docs/src/components/hello-world.vue"
import helloWorld from "%HOME%/VSCodeProjects/ssh-config-cloud/docs/src/components/hello-world.vue"
import helloWorld from "$Env:HOME/VSCodeProjects/ssh-config-cloud/docs/src/components/hello-world.vue"
```

:::



::: tip
You can also prefix the markdown path with @, it will act as the source root. By default, it's the VitePress project root, unless srcDir is configured.

`@ means docs/src`
:::

```md
<<< @/snippets/snippet-with-region.js#snippet{1,2 ts:line-numbers} [snippet with region]
withBase("/ssh/index/")
```
<<< @withBase("/ssh/index/")
## raw

::: raw
import
Wraps in a <div class="vp-raw"/>
:::

## Templates
* readme_vitepress.md
* readme_vitepress_path.md

::: details configs.js
```js
import { defineConfig } from 'vitepress'
//append to generated:
export default defineConfig({
  base:"/ssh-config-cloud/",
  srcDir: './src',//relative to the package.json vitepress dev <dir>
  lang: 'en-ca',
  //section inside
  themeConfig: {
    //add better search. https://vitepress.dev/reference/default-theme-search#local-search
    search: {
      provider: 'local'
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/codeforwings/material-design-3-import-export-ext' }
    ],
    markdown:{
      //https://vitepress.dev/reference/site-config#markdown
      lineNumbers: true,
      space_size: 2,//not sure if this works
    }
  }
})
```
```js [docs/.vitepress/config.js]
import { fileURLToPath } from 'url';
const vite = {
    define: { 'process.env': {HOME:'c:/Users/Jason'} },
    resolve: {
      alias: {
        // https://vitejs.dev/config/shared-options.html#resolve-alias
        //https://nodejs.dev/en/api/v18/packages/#subpath-imports
        '##': fileURLToPath(new URL('../..', import.meta.url)),//.vitepress
        '#src': fileURLToPath(new URL('./src', import.meta.url)),//vitesrc... not needed?
        '#docs': fileURLToPath(new URL('../', import.meta.url)),
        //'../..' = path.relative('docs/.vitepress',process.cwd());import {relative} from "node:path/posix";
      },
    }
};
```
```js [vite.config.mjs]
import { fileURLToPath } from 'url';
const vite = {
    define: { 'process.env': {} },
    resolve: {
      alias: {
        // https://vitejs.dev/config/shared-options.html#resolve-alias
        //https://nodejs.dev/en/api/v18/packages/#subpath-imports
        '##': fileURLToPath(new URL('./.', import.meta.url)),//CWD
        '#src': fileURLToPath(new URL('./src', import.meta.url)),
        '#docs': fileURLToPath(new URL('./docs', import.meta.url)),
      },
    }
};
```
```js
const package = { /* node sub paths */
    "imports": {
    "##/*": {
      "default": "./*"
    },
    "#src/*": {
      "default": "./src/*"
    },
    "#docs/*": {
      "default": "./docs/*"
    }
  }
}
```
:::
## Folder Tree

::: code-group
```txt [folder-tree]
docs
├── lib
│   └── gh-pages-push
│       └── ghPagesDeploy.mjs
├── src
│   ├── public
│   └── ssh
│      └── index.md
└── .vitepress
    ├── cache
    │   └── deps
    ├── dist
    ├── theme
    │   ├── index.js
    │   └── style.css
    └── config.js
```
```bash
tree docs -a -L 3 --filelimit 8 --dirsfirst
```
:::

[//]: # (* need glob)
[//]: # (add to gist)

## Webstorm / VSCode shorcuts
* todo
* nuxt3-win32-posix-path.git

## Vue Utils
* todo
* img-anchor

::: details
:::code-group
```vue
<script setup>
</script>
<template>
<span>Hello World</span>
</template>
<style scoped>
</style>
```
```js
import helloWorld from "@/components/hello-world.vue"
```

:::


## Install
```bash
pnpm add -D vitepress
pnpm dlx vitepress init
pnpm add vue -D
```
```txt [.gitignore]
/docs/.vitepress/cache/
/docs/.vitepress/dist/
```

## Markdown-it
* todo