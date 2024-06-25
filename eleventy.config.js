// This file is the entry point for all 11ty configuration.
// It configures the core 11ty behavior and registers
// plugins and customization that live in `/src/_11ty`.

import { registerFilters } from './src/_11ty/filters.js';
import { registerShortcodes } from './src/_11ty/shortcodes.js';
import { markdown } from './src/_11ty/plugins/markdown.js';
import { configureHighlighting } from './src/_11ty/plugins/highlight.js';

import minifier from 'html-minifier-terser';
import yaml from 'js-yaml';
import { EleventyRenderPlugin } from '@11ty/eleventy';

import * as path from 'node:path';
import * as sass from 'sass';

// noinspection JSUnusedGlobalSymbols
/**
 * @typedef {import('11ty/eleventy/UserConfig')} EleventyConfig
 * @param {EleventyConfig} eleventyConfig
 */
export default function (eleventyConfig) {
  const isProduction = process.env.PRODUCTION === 'true';
  const shouldOptimize = process.env.OPTIMIZE === 'true';

  eleventyConfig.on('eleventy.before', async () => {
    await configureHighlighting(markdown);
  });

  eleventyConfig.addGlobalData('isProduction', isProduction);

  eleventyConfig.setLibrary('md', markdown);

  eleventyConfig.addDataExtension('yml,yaml', (contents) =>
      yaml.load(contents),
  );

  eleventyConfig.setLiquidOptions({
    cache: true,
    strictFilters: true,
    lenientIf: true,
    jekyllInclude: true,
  });

  eleventyConfig.addPlugin(EleventyRenderPlugin);

  registerFilters(eleventyConfig);
  registerShortcodes(eleventyConfig);

  eleventyConfig.addTemplateFormats('scss');
  eleventyConfig.addWatchTarget('src/_sass');
  eleventyConfig.addExtension('scss', {
    outputFileExtension: 'css',
    compile: function (inputContent, inputPath) {
      const parsedPath = path.parse(inputPath);
      if (parsedPath.name.startsWith('_')) {
        return;
      }

      const result = sass.compileString(inputContent, {
        style: shouldOptimize ? 'compressed' : 'expanded',
        quietDeps: true,
        loadPaths: [parsedPath.dir, 'src/_sass'],
      });

      const dependencies = result.loadedUrls
          .filter(
              (loadedUrl) =>
                  loadedUrl.protocol === 'file:' && loadedUrl.pathname !== '',
          )
          .map((url) => path.relative('.', url.pathname));

      this.addDependencies(inputPath, dependencies);

      return () => result.css;
    },
  });

  eleventyConfig.addPassthroughCopy('src/content/assets/js');
  eleventyConfig.addPassthroughCopy({'site-shared/packages/inject_dartpad/lib/inject_dartpad.js': 'assets/js/inject_dartpad.js'});
  eleventyConfig.addPassthroughCopy('src/content/assets/images', { expand: true });
  eleventyConfig.addPassthroughCopy('src/content/cookbook/img-files', { expand: true });
  eleventyConfig.addPassthroughCopy('src/content/f', {
    expand: true,
    filter: /^(?!_).+/,
  });
  eleventyConfig.addPassthroughCopy('src/content/tools/devtools/release-notes', {
    filter: (path) => path.includes('src') || path.includes('images'),
  });

  if (shouldOptimize) {
    // If building for production, minify/optimize the HTML output.
    // Doing so during serving isn't worth the extra build time.
    eleventyConfig.addTransform('minify-html', async function (content) {
      if (this.page.outputPath && this.page.outputPath.endsWith('.html')) {
        // Minify the page's content if it's an HTML file.
        // Other options can be enabled, but each should be tested.
        return await minifier.minify(content, {
          useShortDoctype: true,
          removeComments: true,
          collapseWhitespace: true,
          minifyJS: true,
        });
      }

      return content;
    });
  }

  eleventyConfig.setQuietMode(true);

  eleventyConfig.setServerOptions({
    port: 4000,
    watch: ['src/_sass'],
  });

  return {
    htmlTemplateEngine: 'liquid',
    dir: {
      input: 'src/content',
      output: '_site',
      layouts: '../_layouts',
      includes: '../_includes',
      data: '../_data',
    },
  };
}
