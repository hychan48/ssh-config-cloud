/**
 * pnpm install gh-pages -D
 * https://yarnpkg.com/package/gh-pages
 *
 * pnpm run build
 *
 * make sure this file is run as root
 *
 * for nuxt3... it should really remove .nuxt and .output
 * Maybe look at changing it
 *
 * node docs/lib/gh-pages-push/ghPagesDeploy.mjs
 * "ghPagesDeploy": "node docs/lib/gh-pages-push/ghPagesDeploy.mjs",
 *
 * deploy/
 * look into nuxt3-win32-posix-path.git
 *
 */

/* pseudo params */
let distDirToPush = 'docs/.vitepress/dist'; //or from env variable? perhaps or from args or common folders
// distDirToPush = 'dist'; //or from env variable? perhaps or from args or common folders
let packageCmdToGenerateDist = 'docs:build';// repressive. add typedefs... / lookup
// packageCmdToGenerateDist = 'pnpm run build';//vite, change to package.json scripts instead of the full cmd?
// packageCmdToGenerateDist = 'pnpm run generate';//nuxt3 3.0.0 with nitro
/**/
import * as ghPages from 'gh-pages'
// import {execCmdOnController} from "./SpawnExecOnController.mjs";
import {spawnSync} from 'node:child_process';
import fs from 'node:fs';
// process.env.NUXT_APP_BASE_URL="/nuxt3-win32-posix-path/"
//build
{
  // const {cmd,stdout,stderr,code,signal} = spawnSync(packageCmdToGenerateDist, {shell:true})// shell true is needed for spawnSync
  const {output,status,stdout,stderr,error,signal} = spawnSync('pnpm',['run',packageCmdToGenerateDist],{shell:true});
  const code = status;
  console.log(stdout.toString());
  if(stderr || code !== 0){
    console.error('error',stderr?.toString());
  }
  if(code !==0){process.exit(code)}

}
// process.exit(0);//debug
/* add nojekyl */
fs.writeFileSync(distDirToPush+"/.nojekyll","");

const options = {
  dotfiles:true,
}
await ghPages.publish(distDirToPush, options, function(err) {
  if(err){
    console.error('publish error',err);
  }else{
    console.log('Pushed')
  }
});
