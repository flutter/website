// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'review_styles.dart';

/// Builds the self-contained client-side JavaScript bundle for the visual
/// review overlay.
///
/// All UI is rendered inside `#dash-review-host`'s open Shadow DOM using
/// `document.createElement` and `textContent` (never `innerHTML`) to prevent
/// CSS collisions and DOM-based XSS.
String buildReviewClientScript() => _reviewClientScriptBody.replaceFirst(
  '__DASH_REVIEW_STYLES_PLACEHOLDER__',
  _escapeJsTemplateLiteral(reviewOverlayStyles),
);

String _escapeJsTemplateLiteral(String input) => input
    .replaceAll(r'\', r'\\')
    .replaceAll('`', r'\`')
    .replaceAll(r'$', r'\$')
    .replaceAll('</', r'<\/')
    .replaceAll('<!--', r'\x3c!--');

const String _reviewClientScriptBody = r'''
(function () {
  'use strict';

  if (typeof window === 'undefined' || typeof document === 'undefined') return;
  if (window.__dashReviewMounted) return;
  window.__dashReviewMounted = true;

  const STYLES = `__DASH_REVIEW_STYLES_PLACEHOLDER__`;
  const SVG_NS = 'http://www.w3.org/2000/svg';
  const STORAGE_TOKEN_KEY = 'dash_review_gh_token';
  const STORAGE_REPO_KEY = 'dash_review_repo_override';
  const STORAGE_PR_KEY = 'dash_review_pr_override';
  const STORAGE_AUTHOR_KEY = 'dash_review_author';
  const META_OPEN = '<' + '!-- dash-review-meta: ';
  const META_CLOSE = ' --' + '>';
  const META_REGEX = new RegExp(
    '<' + '!--\\s*dash-review-meta:\\s*(\\{[\\s\\S]*?\\})\\s*--' + '>'
  );

  const ICONS = {
    comment: 'M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z',
    crosshair: 'M12 2v4M12 18v4M2 12h4M18 12h4M12 12m-6 0a6 6 0 1 0 12 0a6 6 0 1 0-12 0',
    list: 'M8 6h13M8 12h13M8 18h13M3 6h.01M3 12h.01M3 18h.01',
    copy: 'M9 9h10v11H9zM5 15H4a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v1',
    settings: 'M12 15a3 3 0 1 0 0-6 3 3 0 0 0 0 6zM19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 1 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 1 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 1 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9c.26.6.77 1.02 1.51 1H21a2 2 0 1 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z',
    close: 'M18 6L6 18M6 6l12 12',
    check: 'M20 6L9 17l-5-5',
    trash: 'M3 6h18M8 6V4h8v2M19 6l-1 14H6L5 6',
    terminal: 'M4 17l6-6-6-6M12 19h8',
    minimize: 'M6 9l6 6 6-6',
    expand: 'M18 15l-6-6-6 6'
  };

  function readConfig() {
    const node = document.getElementById('dash-review-config');
    if (!node || !node.textContent) return null;
    try {
      const parsed = JSON.parse(node.textContent);
      if (!parsed || (parsed.mode !== 'local' && parsed.mode !== 'preview')) {
        return null;
      }
      return {
        mode: String(parsed.mode),
        site: String(parsed.site || 'www'),
        pageUrl: String(parsed.pageUrl || window.location.pathname || '/'),
        pageTitle: String(parsed.pageTitle || document.title || ''),
        sourceFile: String(parsed.sourceFile || ''),
        serverOrigin: String(parsed.serverOrigin || ''),
        prNumber: String(parsed.prNumber || ''),
        repo: String(parsed.repo || 'flutter/website'),
        commitSha: String(parsed.commitSha || ''),
        headBranch: String(parsed.headBranch || '')
      };
    } catch (_) {
      return null;
    }
  }

  function safeStorageGet(key) {
    try {
      return window.localStorage.getItem(key) || '';
    } catch (_) {
      return '';
    }
  }

  function safeStorageSet(key, val) {
    try {
      if (val === '' || val === null || val === undefined) {
        window.localStorage.removeItem(key);
      } else {
        window.localStorage.setItem(key, String(val));
      }
    } catch (_) {
      // Ignore storage quota or privacy mode errors.
    }
  }

  function parsePrFromHostname(hostname) {
    const h = String(hostname || '');
    const m = h.match(/--pr-?(\d+)(?:[-.]|$)/i);
    return m ? m[1] : '';
  }

  function shellQuote(value) {
    return "'" + String(value == null ? '' : value).split("'").join("'\\''") + "'";
  }

  function normalizePageUrl(url) {
    const raw = String(url || '').split('#')[0].split('?')[0].trim();
    if (!raw || raw === '/') return '/';
    const withSlash = raw.startsWith('/') ? raw : '/' + raw;
    const stripped = withSlash
      .replace(/\/index\.html$/i, '')
      .replace(/\.html$/i, '')
      .replace(/\/+$/, '');
    return stripped || '/';
  }

  function roundPct(n) {
    const v = Number(n);
    if (!Number.isFinite(v)) return 0;
    return Math.round(Math.max(0, Math.min(100, v)) * 1000) / 1000;
  }

  function stripMarkdownInline(text) {
    return String(text || '')
      .replace(/!\[([^\]]*)\]\([^)]*\)/g, '$1')
      .replace(/\[([^\]]+)\]\([^)]*\)/g, '$1')
      .replace(/\[([^\]]+)\]\[[^\]]*\]/g, '$1')
      .replace(/`+([^`]+)`+/g, '$1')
      .replace(/(\*\*|__|\*|_)(.*?)\1/g, '$2')
      .replace(/\{#[-a-zA-Z0-9_]+\}/g, '')
      .replace(/\s+/g, ' ')
      .trim();
  }

  function slugifyHeading(text) {
    return stripMarkdownInline(text)
      .toLowerCase()
      .replace(/[^\w\s-]/g, '')
      .trim()
      .replace(/[\s]+/g, '-');
  }

  function parseDiffRightSideLines(patch) {
    if (!patch || typeof patch !== 'string') return [];
    const lines = patch.split('\n');
    const result = [];
    let rightLine = 0;
    let inHunk = false;

    for (let i = 0; i < lines.length; i++) {
      const raw = lines[i];
      const hunkMatch = raw.match(/^@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@/);
      if (hunkMatch) {
        rightLine = parseInt(hunkMatch[1], 10);
        inHunk = true;
        continue;
      }
      if (!inHunk) continue;
      if (raw.startsWith('+')) {
        result.push({ line: rightLine, text: raw.slice(1), kind: 'add' });
        rightLine += 1;
      } else if (raw.startsWith(' ')) {
        result.push({ line: rightLine, text: raw.slice(1), kind: 'context' });
        rightLine += 1;
      } else if (raw.startsWith('-')) {
        // Deleted line on LEFT; does not advance RIGHT line counter.
      } else if (raw.startsWith('\\')) {
        // "\ No newline at end of file"
      }
    }
    return result;
  }

  function matchNeedleInRightLines(rightLines, rawNeedle, headingAnchor) {
    if (!rightLines || rightLines.length === 0) return null;
    const needle = String(rawNeedle || '').trim();
    const normNeedle = stripMarkdownInline(needle).toLowerCase();

    if (needle.length >= 2) {
      let contextMatch = null;
      for (let i = 0; i < rightLines.length; i++) {
        const entry = rightLines[i];
        if (entry.text.includes(needle)) {
          if (entry.kind === 'add') {
            return { startLine: entry.line, endLine: entry.line, line: entry.line };
          }
          if (!contextMatch) {
            contextMatch = { startLine: entry.line, endLine: entry.line, line: entry.line };
          }
        }
      }
      if (contextMatch) return contextMatch;

      if (normNeedle.length >= 3) {
        for (let i = 0; i < rightLines.length; i++) {
          const normLine = stripMarkdownInline(rightLines[i].text).toLowerCase();
          if (normLine && (normLine.includes(normNeedle) || (normLine.length >= 12 && normNeedle.includes(normLine)))) {
            return {
              startLine: rightLines[i].line,
              endLine: rightLines[i].line,
              line: rightLines[i].line
            };
          }
        }
        // Multi-line sliding window (up to 6 consecutive diff lines).
        for (let i = 0; i < rightLines.length; i++) {
          let combined = '';
          for (let j = i; j < Math.min(rightLines.length, i + 6); j++) {
            if (j > i && rightLines[j].line !== rightLines[j - 1].line + 1) break;
            combined = (combined ? combined + ' ' : '') + stripMarkdownInline(rightLines[j].text);
            if (combined.toLowerCase().includes(normNeedle)) {
              return {
                startLine: rightLines[i].line,
                endLine: rightLines[j].line,
                line: rightLines[j].line
              };
            }
          }
        }
      }
    }

    const slug = String(headingAnchor || '').replace(/^#/, '').trim().toLowerCase();
    if (slug) {
      for (let i = 0; i < rightLines.length; i++) {
        const lineText = rightLines[i].text;
        if (/^\s*#{1,6}\s+/.test(lineText)) {
          const explicitId = lineText.match(/\{#([-a-zA-Z0-9_]+)\}/);
          const headingText = lineText.replace(/^\s*#{1,6}\s+/, '');
          if (
            (explicitId && explicitId[1].toLowerCase() === slug) ||
            slugifyHeading(headingText) === slug
          ) {
            return {
              startLine: rightLines[i].line,
              endLine: rightLines[i].line,
              line: rightLines[i].line
            };
          }
        }
      }
    }
    return null;
  }

  function matchNeedleInFullText(content, rawNeedle, headingAnchor) {
    if (!content) return null;
    const rawLines = String(content).replace(/\r\n/g, '\n').split('\n');
    const needle = String(rawNeedle || '').trim();
    if (needle.length >= 2) {
      const idx = content.indexOf(needle);
      if (idx !== -1) {
        const startLine = content.slice(0, idx).split('\n').length;
        const endLine = startLine + needle.split('\n').length - 1;
        return { startLine: startLine, endLine: endLine };
      }
      const normNeedle = stripMarkdownInline(needle).toLowerCase();
      if (normNeedle.length >= 3) {
        for (let i = 0; i < rawLines.length; i++) {
          let combined = '';
          for (let j = i; j < Math.min(rawLines.length, i + 6); j++) {
            combined = (combined ? combined + ' ' : '') + stripMarkdownInline(rawLines[j]);
            if (combined.toLowerCase().includes(normNeedle)) {
              return { startLine: i + 1, endLine: j + 1 };
            }
          }
        }
      }
    }
    const slug = String(headingAnchor || '').replace(/^#/, '').trim().toLowerCase();
    if (slug) {
      for (let i = 0; i < rawLines.length; i++) {
        const lineText = rawLines[i];
        if (/^\s*#{1,6}\s+/.test(lineText)) {
          const explicitId = lineText.match(/\{#([-a-zA-Z0-9_]+)\}/);
          const headingText = lineText.replace(/^\s*#{1,6}\s+/, '');
          if (
            (explicitId && explicitId[1].toLowerCase() === slug) ||
            slugifyHeading(headingText) === slug
          ) {
            return { startLine: i + 1, endLine: i + 1 };
          }
        }
      }
    }
    return null;
  }

  function el(tag, opts, children) {
    const node = document.createElement(tag);
    node.setAttribute('data-dash-review-ignore', 'true');
    if (opts) {
      if (opts.className) node.className = opts.className;
      if (opts.text != null) node.textContent = String(opts.text);
      if (opts.attrs) {
        const keys = Object.keys(opts.attrs);
        for (let i = 0; i < keys.length; i++) {
          const k = keys[i];
          const v = opts.attrs[k];
          if (v !== null && v !== undefined && v !== false) {
            node.setAttribute(k, v === true ? '' : String(v));
          }
        }
      }
      if (opts.style) {
        const sKeys = Object.keys(opts.style);
        for (let i = 0; i < sKeys.length; i++) {
          node.style[sKeys[i]] = opts.style[sKeys[i]];
        }
      }
      if (opts.on) {
        const eKeys = Object.keys(opts.on);
        for (let i = 0; i < eKeys.length; i++) {
          node.addEventListener(eKeys[i], opts.on[eKeys[i]]);
        }
      }
    }
    if (Array.isArray(children)) {
      for (let i = 0; i < children.length; i++) {
        const c = children[i];
        if (c == null || c === false) continue;
        if (typeof c === 'string' || typeof c === 'number') {
          node.appendChild(document.createTextNode(String(c)));
        } else {
          node.appendChild(c);
        }
      }
    }
    return node;
  }

  function icon(name, size) {
    const dim = String(size || 14);
    const svg = document.createElementNS(SVG_NS, 'svg');
    svg.setAttribute('viewBox', '0 0 24 24');
    svg.setAttribute('width', dim);
    svg.setAttribute('height', dim);
    svg.setAttribute('fill', 'none');
    svg.setAttribute('stroke', 'currentColor');
    svg.setAttribute('stroke-width', '2');
    svg.setAttribute('stroke-linecap', 'round');
    svg.setAttribute('stroke-linejoin', 'round');
    svg.setAttribute('aria-hidden', 'true');
    const path = document.createElementNS(SVG_NS, 'path');
    path.setAttribute('d', ICONS[name] || ICONS.comment);
    svg.appendChild(path);
    return svg;
  }

  function clearChildren(node) {
    while (node.firstChild) {
      node.removeChild(node.firstChild);
    }
  }

  function cssEscapeIdent(ident) {
    if (typeof CSS !== 'undefined' && typeof CSS.escape === 'function') {
      return CSS.escape(ident);
    }
    return String(ident).replace(/[^a-zA-Z0-9_-]/g, '\\$&');
  }

  function buildElementSelector(target) {
    if (!target || target.nodeType !== 1) return 'body';
    if (target.id && !target.id.startsWith('dash-review')) {
      return '#' + cssEscapeIdent(target.id);
    }
    const parts = [];
    let cur = target;
    let depth = 0;
    while (
      cur &&
      cur.nodeType === 1 &&
      cur !== document.body &&
      cur !== document.documentElement &&
      depth < 5
    ) {
      if (cur.id && !cur.id.startsWith('dash-review')) {
        parts.unshift('#' + cssEscapeIdent(cur.id));
        break;
      }
      const tag = cur.tagName.toLowerCase();
      let nth = 1;
      let sameTagCount = 0;
      const parent = cur.parentElement;
      if (parent) {
        const siblings = parent.children;
        for (let i = 0; i < siblings.length; i++) {
          if (siblings[i].tagName === cur.tagName) {
            sameTagCount += 1;
            if (siblings[i] === cur) nth = sameTagCount;
          }
        }
      }
      parts.unshift(sameTagCount > 1 ? tag + ':nth-of-type(' + nth + ')' : tag);
      cur = parent;
      depth += 1;
    }
    return parts.join(' > ') || target.tagName.toLowerCase();
  }

  function findNearestHeadingAnchor(target) {
    let cur = target && target.nodeType === 1 ? target : target && target.parentElement;
    while (cur && cur !== document.body && cur !== document.documentElement) {
      if (/^H[1-6]$/.test(cur.tagName) && cur.id) {
        return '#' + cur.id;
      }
      let prev = cur.previousElementSibling;
      while (prev) {
        if (/^H[1-6]$/.test(prev.tagName) && prev.id) {
          return '#' + prev.id;
        }
        const nested = prev.querySelectorAll ? prev.querySelectorAll('h1[id],h2[id],h3[id],h4[id],h5[id],h6[id]') : [];
        if (nested.length > 0) {
          return '#' + nested[nested.length - 1].id;
        }
        prev = prev.previousElementSibling;
      }
      cur = cur.parentElement;
    }
    return '';
  }

  function querySelectorSafe(selector) {
    if (!selector || typeof selector !== 'string') return null;
    try {
      const found = document.querySelector(selector);
      if (found && found.id !== 'dash-review-host' && !found.closest('#dash-review-host')) {
        return found;
      }
    } catch (_) {
      // Ignore malformed selectors from external metadata.
    }
    return null;
  }

  function locateTextRangeInElement(rootEl, selectedText, prefixContext, suffixContext) {
    const needle = String(selectedText || '');
    if (!rootEl || !needle) return null;
    const walker = document.createTreeWalker(rootEl, NodeFilter.SHOW_TEXT);
    const segments = [];
    let full = '';
    let n;
    while ((n = walker.nextNode())) {
      const val = n.nodeValue || '';
      if (!val) continue;
      segments.push({ node: n, start: full.length, end: full.length + val.length });
      full += val;
    }
    if (!full) return null;

    let searchNeedle = needle;
    let bestIdx = -1;
    let bestScore = -1;
    let pos = 0;

    while (pos <= full.length) {
      const idx = full.indexOf(searchNeedle, pos);
      if (idx === -1) break;
      let score = 1;
      if (prefixContext) {
        const before = full.slice(Math.max(0, idx - prefixContext.length - 10), idx);
        if (before.includes(prefixContext.slice(-15))) score += 5;
      }
      if (suffixContext) {
        const after = full.slice(
          idx + searchNeedle.length,
          idx + searchNeedle.length + suffixContext.length + 10
        );
        if (after.includes(suffixContext.slice(0, 15))) score += 5;
      }
      if (score > bestScore) {
        bestScore = score;
        bestIdx = idx;
      }
      pos = idx + 1;
    }

    if (bestIdx === -1 && needle.trim() !== needle) {
      searchNeedle = needle.trim();
      bestIdx = full.indexOf(searchNeedle);
    }
    if (bestIdx === -1) return null;

    const endIdx = bestIdx + searchNeedle.length;
    let startNode = null;
    let startOffset = 0;
    let endNode = null;
    let endOffset = 0;

    for (let i = 0; i < segments.length; i++) {
      const seg = segments[i];
      if (!startNode && bestIdx >= seg.start && bestIdx < seg.end) {
        startNode = seg.node;
        startOffset = bestIdx - seg.start;
      }
      if (endIdx > seg.start && endIdx <= seg.end) {
        endNode = seg.node;
        endOffset = endIdx - seg.start;
        break;
      }
    }
    if (!startNode || !endNode) return null;
    try {
      const range = document.createRange();
      range.setStart(startNode, startOffset);
      range.setEnd(endNode, endOffset);
      return range;
    } catch (_) {
      return null;
    }
  }

  function normalizeCommentRecord(raw, cfg) {
    if (!raw || typeof raw !== 'object') return null;
    const now = new Date().toISOString();
    const rectRaw = raw.rectPct && typeof raw.rectPct === 'object' ? raw.rectPct : {};
    const sourceFile = String(raw.sourceFile || cfg.sourceFile || '');
    return {
      id: String(raw.id || 'rv_' + Date.now() + '_' + Math.random().toString(36).slice(2, 8)),
      site: String(raw.site || cfg.site || 'www'),
      pageUrl: String(raw.pageUrl || cfg.pageUrl || '/'),
      pageTitle: String(raw.pageTitle || cfg.pageTitle || ''),
      sourceFile: sourceFile,
      resolvedFile: String(raw.resolvedFile || sourceFile),
      startLine: Number.isInteger(raw.startLine) ? raw.startLine : null,
      endLine: Number.isInteger(raw.endLine) ? raw.endLine : null,
      codeSnippet: typeof raw.codeSnippet === 'string' ? raw.codeSnippet : null,
      anchorType:
        raw.anchorType === 'text' || raw.anchorType === 'area' || raw.anchorType === 'element'
          ? raw.anchorType
          : 'element',
      selectedText: String(raw.selectedText || ''),
      prefixContext: String(raw.prefixContext || ''),
      suffixContext: String(raw.suffixContext || ''),
      selector: String(raw.selector || 'body'),
      elementTag: String(raw.elementTag || 'div'),
      elementText: String(raw.elementText || ''),
      headingAnchor: String(raw.headingAnchor || ''),
      rectPct: {
        x: roundPct(rectRaw.x != null ? rectRaw.x : 0),
        y: roundPct(rectRaw.y != null ? rectRaw.y : 0),
        w: roundPct(rectRaw.w != null ? rectRaw.w : 100),
        h: roundPct(rectRaw.h != null ? rectRaw.h : 100)
      },
      comment: String(raw.comment || ''),
      author: String(raw.author || safeStorageGet(STORAGE_AUTHOR_KEY) || 'reviewer'),
      status: raw.status === 'resolved' ? 'resolved' : 'open',
      createdAt: String(raw.createdAt || now),
      updatedAt: String(raw.updatedAt || now),
      githubUrl:
        typeof raw.githubUrl === 'string' && raw.githubUrl.startsWith('https://github.com/')
          ? raw.githubUrl
          : '',
      diffMatched: raw.diffMatched === true
    };
  }

  function mountOverlay() {
    const cfg = readConfig();
    if (!cfg) return;

    const state = {
      commentMode: false,
      collapsed: false,
      drawerOpen: false,
      drawerScope: 'page', // 'page' | 'all'
      drawerStatus: 'open', // 'open' | 'resolved' | 'all'
      settingsOpen: false,
      localServerOnline: cfg.mode === 'local' && Boolean(cfg.serverOrigin),
      localHealthInfo: null,
      comments: [],
      activeCommentId: null,
      composerDraft: null, // { draft, anchorRect }
      pendingSelection: null, // { draft, anchorRect }
      hoveredEl: null,
      dragState: null,
      justConsumedClickUntil: 0,
      submitting: false,
      anchorCache: new Map(),
      prFilesCache: new Map(),
      prMetaCache: new Map()
    };

    function effectiveRepo() {
      const ov = safeStorageGet(STORAGE_REPO_KEY).trim();
      const base = ov || cfg.repo || 'flutter/website';
      return /^[A-Za-z0-9_.-]+\/[A-Za-z0-9_.-]+$/.test(base) ? base : 'flutter/website';
    }

    function effectivePrNumber() {
      const ov = safeStorageGet(STORAGE_PR_KEY).trim();
      const candidate = ov || cfg.prNumber || parsePrFromHostname(window.location.hostname);
      return /^\d+$/.test(candidate) ? candidate : '';
    }

    function githubApiBase() {
      const custom = window.__DASH_REVIEW_GITHUB_API_BASE__;
      if (typeof custom === 'string' && custom.trim()) {
        return custom.trim().replace(/\/+$/, '');
      }
      return 'https://api.github.com';
    }

    function localFallbackStorageKey() {
      return 'dash_review_comments_' + cfg.mode + '_' + cfg.site + '_' + (effectivePrNumber() || 'local');
    }

    function readFallbackComments() {
      const raw = safeStorageGet(localFallbackStorageKey());
      if (!raw) return [];
      try {
        const arr = JSON.parse(raw);
        if (!Array.isArray(arr)) return [];
        return arr.map((item) => normalizeCommentRecord(item, cfg)).filter(Boolean);
      } catch (_) {
        return [];
      }
    }

    function writeFallbackComments(list) {
      safeStorageSet(localFallbackStorageKey(), JSON.stringify(list));
    }

    // Create Shadow DOM host
    const host = document.createElement('div');
    host.id = 'dash-review-host';
    host.setAttribute('data-dash-review-ignore', 'true');
    const shadow = host.attachShadow({ mode: 'open' });

    const styleEl = document.createElement('style');
    styleEl.textContent = STYLES;
    shadow.appendChild(styleEl);

    const root = el('div', { className: 'dr-root', attrs: { 'data-theme': 'light' } });
    const highlightLayer = el('div', { className: 'dr-layer' });
    const hoverBox = el('div', { className: 'dr-hover-box dr-hidden' });
    const hoverLabel = el('span', { className: 'dr-hover-label' });
    hoverBox.appendChild(hoverLabel);
    const dragBox = el('div', { className: 'dr-drag-box dr-hidden' });
    const pinsContainer = el('div', { className: 'dr-layer' });

    const selectionPill = el(
      'button',
      {
        className: 'dr-selection-pill dr-hidden',
        attrs: {
          type: 'button',
          'data-testid': 'dr-selection-pill',
          'aria-label': 'Comment on selection'
        },
        on: {
          mousedown: function (e) {
            e.preventDefault();
            e.stopPropagation();
          },
          click: function (e) {
            e.preventDefault();
            e.stopPropagation();
            if (!state.pendingSelection) return;
            const pending = state.pendingSelection;
            state.pendingSelection = null;
            selectionPill.classList.add('dr-hidden');
            openComposer(pending.draft, pending.anchorRect);
          }
        }
      },
      [icon('comment', 13), 'Comment on selection']
    );

    const modeBanner = el('div', { className: 'dr-mode-banner dr-hidden' }, [
      icon('crosshair', 14),
      'Click an element or drag an area to comment',
      el('span', { className: 'dr-kbd', text: 'Esc' }),
      el(
        'button',
        {
          className: 'dr-btn dr-btn-secondary',
          style: { padding: '2px 8px', fontSize: '11px' },
          attrs: { type: 'button' },
          on: {
            click: function () {
              setCommentMode(false);
            }
          }
        },
        ['Cancel']
      )
    ]);

    const composerMount = el('div');
    const threadMount = el('div');
    const drawerMount = el('div');
    const modalMount = el('div');
    const toolbarMount = el('div');
    const toastStack = el('div', { className: 'dr-toast-stack' });

    root.appendChild(highlightLayer);
    root.appendChild(hoverBox);
    root.appendChild(dragBox);
    root.appendChild(pinsContainer);
    root.appendChild(selectionPill);
    root.appendChild(modeBanner);
    root.appendChild(composerMount);
    root.appendChild(threadMount);
    root.appendChild(drawerMount);
    root.appendChild(modalMount);
    root.appendChild(toolbarMount);
    root.appendChild(toastStack);
    shadow.appendChild(root);
    document.body.appendChild(host);

    function syncTheme() {
      const bodyDark =
        document.body.classList.contains('dark-mode') ||
        document.documentElement.classList.contains('dark-mode') ||
        document.documentElement.getAttribute('data-theme') === 'dark';
      const bodyLight =
        document.body.classList.contains('light-mode') ||
        document.documentElement.classList.contains('light-mode');
      const prefersDark =
        typeof window.matchMedia === 'function' &&
        window.matchMedia('(prefers-color-scheme: dark)').matches;
      const isDark = bodyDark || (!bodyLight && prefersDark);
      root.setAttribute('data-theme', isDark ? 'dark' : 'light');
    }
    syncTheme();
    if (typeof MutationObserver !== 'undefined') {
      const obs = new MutationObserver(syncTheme);
      obs.observe(document.body, { attributes: true, attributeFilter: ['class', 'data-theme'] });
    }

    function showToast(message) {
      const toast = el('div', {
        className: 'dr-toast',
        attrs: { role: 'status', 'aria-live': 'polite' },
        text: message
      });
      toastStack.appendChild(toast);
      setTimeout(function () {
        if (toast.parentNode) toast.parentNode.removeChild(toast);
      }, 3600);
    }

    async function copyToClipboard(text, successMsg) {
      let copied = false;
      try {
        if (navigator.clipboard && typeof navigator.clipboard.writeText === 'function') {
          await navigator.clipboard.writeText(text);
          copied = true;
        }
      } catch (_) {
        copied = false;
      }
      if (!copied) {
        const ta = document.createElement('textarea');
        ta.value = text;
        ta.setAttribute('data-dash-review-ignore', 'true');
        ta.style.position = 'fixed';
        ta.style.left = '-9999px';
        document.body.appendChild(ta);
        ta.select();
        try {
          document.execCommand('copy');
          copied = true;
        } catch (_) {
          copied = false;
        }
        document.body.removeChild(ta);
      }
      window.__dashReviewLastCopiedText = text;
      showToast(copied ? successMsg : 'Prepared text (clipboard unavailable)');
      return text;
    }

    function isReviewEvent(e) {
      if (!e) return false;
      if (typeof e.composedPath === 'function') {
        const path = e.composedPath();
        for (let i = 0; i < path.length; i++) {
          const n = path[i];
          if (
            n === host ||
            (n && n.getAttribute && n.getAttribute('data-dash-review-ignore') === 'true')
          ) {
            return true;
          }
        }
      }
      const t = e.target;
      return Boolean(
        t &&
          (t === host ||
            (t.closest && t.closest('#dash-review-host,[data-dash-review-ignore="true"]')))
      );
    }

    function isCurrentPageComment(c) {
      const current = normalizePageUrl(window.location.pathname || cfg.pageUrl);
      const configured = normalizePageUrl(cfg.pageUrl);
      const target = normalizePageUrl(c.pageUrl);
      return target === current || target === configured;
    }

    function currentPageComments() {
      return state.comments
        .filter(isCurrentPageComment)
        .slice()
        .sort(function (a, b) {
          return String(a.createdAt).localeCompare(String(b.createdAt));
        });
    }

    function formatLocationChip(c) {
      const file = c.resolvedFile || c.sourceFile || cfg.sourceFile || 'unknown';
      if (c.startLine && c.endLine && c.endLine > c.startLine) {
        return file + ':' + c.startLine + '-' + c.endLine;
      }
      if (c.startLine) {
        return file + ':' + c.startLine;
      }
      return file;
    }

    function formatAgentPrompt(commentsList) {
      const items = commentsList.filter(Boolean);
      if (items.length === 0) {
        return 'No open visual review comments.';
      }
      const lines = [
        'Please address the following visual review feedback on the `' + cfg.site + '` site:',
        ''
      ];
      for (let i = 0; i < items.length; i++) {
        const c = items[i];
        const loc = formatLocationChip(c);
        lines.push('### ' + (i + 1) + '. `' + loc + '`');
        lines.push(
          '- **Page**: `' +
            c.pageUrl +
            '`' +
            (c.pageTitle ? ' ("' + c.pageTitle + '")' : '')
        );
        lines.push(
          '- **Anchor**: `' +
            c.anchorType +
            '` on `<' +
            c.elementTag +
            '>` (`' +
            c.selector +
            '`)' +
            (c.headingAnchor ? ' near `' + c.headingAnchor + '`' : '')
        );
        const quote = c.selectedText || c.elementText;
        if (quote) {
          lines.push('- **Highlighted Content**:');
          const qLines = quote.trim().split('\n').slice(0, 6);
          for (let q = 0; q < qLines.length; q++) {
            lines.push('  > ' + qLines[q]);
          }
        }
        if (c.codeSnippet) {
          lines.push('- **Source Context**:');
          lines.push('  ```');
          const sLines = c.codeSnippet.split('\n');
          for (let s = 0; s < sLines.length; s++) {
            lines.push('  ' + sLines[s]);
          }
          lines.push('  ```');
        }
        lines.push('- **Reviewer Note**: ' + c.comment.trim());
        lines.push('- **Comment ID**: `' + c.id + '`');
        lines.push('');
      }
      if (cfg.mode === 'local') {
        lines.push(
          'Once fixed, resolve comments via `dart run dash_site review resolve <id>` (or `--all`).'
        );
      }
      return lines.join('\n');
    }

    function buildMetaTagForGithub(record) {
      const metaObj = {
        v: 1,
        id: record.id,
        site: record.site,
        pageUrl: record.pageUrl,
        pageTitle: record.pageTitle,
        sourceFile: record.sourceFile,
        resolvedFile: record.resolvedFile,
        startLine: record.startLine,
        endLine: record.endLine,
        anchorType: record.anchorType,
        selectedText: record.selectedText.slice(0, 400),
        prefixContext: record.prefixContext.slice(0, 40),
        suffixContext: record.suffixContext.slice(0, 40),
        selector: record.selector,
        elementTag: record.elementTag,
        elementText: record.elementText.slice(0, 240),
        headingAnchor: record.headingAnchor,
        rectPct: record.rectPct,
        status: record.status
      };
      const safeJson = JSON.stringify(metaObj)
        .replace(/-->/g, '--\\u003e')
        .replace(/<[/]/g, '<\\/');
      return META_OPEN + safeJson + META_CLOSE;
    }

    function formatGithubCommentBody(record, isInlineDiff) {
      const repo = effectiveRepo();
      const ref = cfg.commitSha || cfg.headBranch || 'main';
      const file = record.resolvedFile || record.sourceFile;
      const lineFragment = record.startLine
        ? record.endLine && record.endLine > record.startLine
          ? '#L' + record.startLine + '-L' + record.endLine
          : '#L' + record.startLine
        : '';
      const fileUrl = file
        ? 'https://github.com/' + repo + '/blob/' + encodeURIComponent(ref) + '/' + file + lineFragment
        : '';
      const previewHref = window.location.origin + record.pageUrl + (record.headingAnchor || '');
      const parts = [];

      if (!isInlineDiff) {
        parts.push('### Visual Preview Feedback (`' + record.pageUrl + '`)');
        parts.push('');
      }
      parts.push(record.comment.trim());
      parts.push('');

      const quote = (record.selectedText || record.elementText || '').trim();
      if (quote) {
        const snippet = quote.length > 280 ? quote.slice(0, 277) + '...' : quote;
        const qLines = snippet.split('\n');
        for (let i = 0; i < qLines.length; i++) {
          parts.push('> ' + qLines[i]);
        }
        parts.push('');
      }

      const metaLinks = ['[Staged Preview](' + previewHref + ')'];
      if (file && fileUrl) {
        metaLinks.push('[`' + file + lineFragment + '`](' + fileUrl + ')');
      }
      if (record.headingAnchor) {
        metaLinks.push('Section `' + record.headingAnchor + '`');
      } else if (record.selector) {
        metaLinks.push('Selector `' + record.selector + '`');
      }
      parts.push('_' + metaLinks.join(' · ') + '_');
      parts.push('');
      parts.push(buildMetaTagForGithub(record));
      return parts.join('\n');
    }

    function buildGhCliCommand(record) {
      const repo = effectiveRepo();
      const pr = effectivePrNumber() || '<PR_NUMBER>';
      const sha = cfg.commitSha.trim();
      const prArg = /^\d+$/.test(pr) ? pr : shellQuote(pr);
      if (record.diffMatched && record.resolvedFile && record.startLine && sha && /^\d+$/.test(pr)) {
        const inlineBody = formatGithubCommentBody(record, true);
        return (
          'gh api ' +
          shellQuote('repos/' + repo + '/pulls/' + pr + '/comments') +
          ' -f body=' +
          shellQuote(inlineBody) +
          ' -f commit_id=' +
          shellQuote(sha) +
          ' -f path=' +
          shellQuote(record.resolvedFile) +
          ' -F line=' +
          Number(record.startLine) +
          ' -f side=RIGHT'
        );
      }
      const issueBody = formatGithubCommentBody(record, false);
      return (
        'gh pr comment ' +
        prArg +
        ' --repo ' +
        shellQuote(repo) +
        ' --body ' +
        shellQuote(issueBody)
      );
    }

    function githubHeaders(token) {
      const h = {
        Accept: 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28'
      };
      if (token) {
        h.Authorization = 'Bearer ' + token;
      }
      return h;
    }

    function encodeRepoPath(filePath) {
      return String(filePath || '')
        .split('/')
        .map(encodeURIComponent)
        .join('/');
    }

    async function resolvePrDiffLocation(draft, token) {
      const repo = effectiveRepo();
      const pr = effectivePrNumber();
      if (!pr) {
        return { headSha: cfg.commitSha, matchedPath: '', matchedLine: null, startLine: null, endLine: null };
      }
      const cacheKey = repo + '#' + pr;
      const api = githubApiBase();
      let headSha = cfg.commitSha.trim();

      if (!headSha) {
        if (state.prMetaCache.has(cacheKey)) {
          headSha = state.prMetaCache.get(cacheKey);
        } else {
          try {
            const prRes = await fetch(api + '/repos/' + repo + '/pulls/' + pr, {
              headers: githubHeaders(token)
            });
            if (prRes.ok) {
              const prData = await prRes.json();
              if (prData && prData.head && prData.head.sha) {
                headSha = String(prData.head.sha);
                state.prMetaCache.set(cacheKey, headSha);
              }
            }
          } catch (_) {
            // Continue; headSha may be recovered from file contents_url or fallback to issue comment.
          }
        }
      }

      let files = state.prFilesCache.get(cacheKey);
      if (!files) {
        try {
          const filesRes = await fetch(
            api + '/repos/' + repo + '/pulls/' + pr + '/files?per_page=100',
            { headers: githubHeaders(token) }
          );
          if (filesRes.ok) {
            const parsed = await filesRes.json();
            if (Array.isArray(parsed)) {
              files = parsed;
              state.prFilesCache.set(cacheKey, files);
            }
          }
        } catch (_) {
          files = null;
        }
      }
      if (!Array.isArray(files) || files.length === 0) {
        return { headSha: headSha, matchedPath: '', matchedLine: null, startLine: null, endLine: null };
      }

      if (!headSha) {
        for (let i = 0; i < files.length; i++) {
          const cu = files[i] && typeof files[i].contents_url === 'string' ? files[i].contents_url : '';
          const refMatch = cu.match(/[?&]ref=([0-9a-fA-F]{7,40})/);
          if (refMatch) {
            headSha = refMatch[1];
            break;
          }
        }
      }

      const src = draft.sourceFile;
      function filePriority(f) {
        const name = String((f && f.filename) || '');
        if (src && name === src) return 0;
        if (src && (name === src.replace(/\.html$/, '.md') || name === src + '/index.md')) return 1;
        if (name.startsWith('sites/' + cfg.site + '/')) return 2;
        if (name.startsWith('packages/site_shared/')) return 3;
        if (name.startsWith('examples/')) return 4;
        return 5;
      }

      const ordered = files.slice().sort(function (a, b) {
        return filePriority(a) - filePriority(b);
      });

      const primaryNeedle = (draft.selectedText || draft.elementText || '').trim();
      for (let i = 0; i < ordered.length; i++) {
        const f = ordered[i];
        if (!f || !f.filename || f.status === 'removed' || !f.patch) continue;
        const rightLines = parseDiffRightSideLines(f.patch);
        const hit = matchNeedleInRightLines(
          rightLines,
          primaryNeedle,
          f.filename === src ? draft.headingAnchor : ''
        );
        if (hit) {
          return {
            headSha: headSha,
            matchedPath: String(f.filename),
            matchedLine: hit.line,
            startLine: hit.startLine,
            endLine: hit.endLine
          };
        }
      }

      // If sourceFile is in the PR diff (or exists in repo at headSha), try raw file lookup
      // to resolve exact startLine/endLine and verify whether that line is reachable in patch.
      if (src && headSha) {
        try {
          const contentRes = await fetch(
            api +
              '/repos/' +
              repo +
              '/contents/' +
              encodeRepoPath(src) +
              '?ref=' +
              encodeURIComponent(headSha),
            { headers: githubHeaders(token) }
          );
          if (contentRes.ok) {
            const contentData = await contentRes.json();
            if (contentData && typeof contentData.content === 'string') {
              const b64 = contentData.content.replace(/\s+/g, '');
              const bin = atob(b64);
              const bytes = new Uint8Array(bin.length);
              for (let b = 0; b < bin.length; b++) bytes[b] = bin.charCodeAt(b);
              const decoded = new TextDecoder('utf-8').decode(bytes);
              const fullHit = matchNeedleInFullText(decoded, primaryNeedle, draft.headingAnchor);
              if (fullHit) {
                const prFile = ordered.find(function (item) {
                  return item && item.filename === src && item.patch;
                });
                let diffLine = null;
                if (prFile) {
                  const rightLines = parseDiffRightSideLines(prFile.patch);
                  const validSet = new Set(
                    rightLines.map(function (r) {
                      return r.line;
                    })
                  );
                  if (validSet.has(fullHit.endLine)) diffLine = fullHit.endLine;
                  else if (validSet.has(fullHit.startLine)) diffLine = fullHit.startLine;
                }
                return {
                  headSha: headSha,
                  matchedPath: src,
                  matchedLine: diffLine,
                  startLine: fullHit.startLine,
                  endLine: fullHit.endLine
                };
              }
            }
          }
        } catch (_) {
          // Proceed gracefully to top-level PR comment fallback.
        }
      }

      return { headSha: headSha, matchedPath: '', matchedLine: null, startLine: null, endLine: null };
    }

    async function postCommentToGithubPr(record, token) {
      const repo = effectiveRepo();
      const pr = effectivePrNumber();
      if (!pr) {
        throw new Error('PR number is not set. Configure PR number in Review Settings.');
      }
      const api = githubApiBase();
      const mapped = await resolvePrDiffLocation(record, token);
      if (mapped.matchedPath) {
        record.resolvedFile = mapped.matchedPath;
      }
      if (mapped.startLine) record.startLine = mapped.startLine;
      if (mapped.endLine) record.endLine = mapped.endLine;

      // 1. Try inline PR diff review comment when a RIGHT-side diff line matched.
      if (mapped.headSha && mapped.matchedPath && mapped.matchedLine) {
        record.diffMatched = true;
        const inlineBody = formatGithubCommentBody(record, true);
        let authFailureMessage = '';
        try {
          const inlineRes = await fetch(
            api + '/repos/' + repo + '/pulls/' + pr + '/comments',
            {
              method: 'POST',
              headers: Object.assign(
                { 'Content-Type': 'application/json' },
                githubHeaders(token)
              ),
              body: JSON.stringify({
                body: inlineBody,
                commit_id: mapped.headSha,
                path: mapped.matchedPath,
                line: mapped.matchedLine,
                side: 'RIGHT'
              })
            }
          );
          if (inlineRes.ok) {
            const data = await inlineRes.json();
            record.id = 'gh_review_' + String(data.id || Date.now());
            record.githubUrl =
              typeof data.html_url === 'string' && data.html_url.startsWith('https://github.com/')
                ? data.html_url
                : '';
            if (data.user && data.user.login) record.author = String(data.user.login);
            return { mode: 'inline', line: mapped.matchedLine, path: mapped.matchedPath };
          }
          if (inlineRes.status === 401 || inlineRes.status === 403) {
            const errText = await inlineRes.text();
            authFailureMessage =
              'GitHub auth error (' + inlineRes.status + '): ' + errText.slice(0, 140);
          }
        } catch (_) {
          // Fall through to top-level PR issue comment fallback.
        }
        if (authFailureMessage) {
          throw new Error(authFailureMessage);
        }
      }

      // 2. Automatic fallback to rich top-level PR issue comment.
      record.diffMatched = false;
      const issueBody = formatGithubCommentBody(record, false);
      const issueRes = await fetch(
        api + '/repos/' + repo + '/issues/' + pr + '/comments',
        {
          method: 'POST',
          headers: Object.assign(
            { 'Content-Type': 'application/json' },
            githubHeaders(token)
          ),
          body: JSON.stringify({ body: issueBody })
        }
      );
      if (!issueRes.ok) {
        const errText = await issueRes.text();
        throw new Error('GitHub PR comment failed (' + issueRes.status + '): ' + errText.slice(0, 140));
      }
      const issueData = await issueRes.json();
      record.id = 'gh_issue_' + String(issueData.id || Date.now());
      record.githubUrl =
        typeof issueData.html_url === 'string' && issueData.html_url.startsWith('https://github.com/')
          ? issueData.html_url
          : '';
      if (issueData.user && issueData.user.login) record.author = String(issueData.user.login);
      return { mode: 'issue' };
    }

    function extractHumanBodyFromGithubComment(rawBody) {
      const withoutMeta = String(rawBody || '').replace(META_REGEX, '').trim();
      const lines = withoutMeta.split('\n');
      const cleaned = [];
      for (let i = 0; i < lines.length; i++) {
        const line = lines[i];
        if (i === 0 && /^### Visual Preview Feedback\b/.test(line)) {
          if (lines[i + 1] === '') i += 1;
          continue;
        }
        if (/^_\[Staged Preview\]\(/.test(line)) continue;
        if (line.startsWith('> ')) continue;
        cleaned.push(line);
      }
      return cleaned.join('\n').trim() || withoutMeta;
    }

    async function hydratePreviewCommentsFromGithub() {
      const localCached = readFallbackComments();
      const byId = new Map();
      for (let i = 0; i < localCached.length; i++) {
        byId.set(localCached[i].id, localCached[i]);
      }

      const repo = effectiveRepo();
      const pr = effectivePrNumber();
      if (pr && repo) {
        const token = safeStorageGet(STORAGE_TOKEN_KEY).trim();
        const api = githubApiBase();
        const headers = githubHeaders(token);
        try {
          const responses = await Promise.allSettled([
            fetch(api + '/repos/' + repo + '/pulls/' + pr + '/comments?per_page=100', { headers: headers }),
            fetch(api + '/repos/' + repo + '/issues/' + pr + '/comments?per_page=100', { headers: headers })
          ]);
          const buckets = [
            { prefix: 'gh_review_', result: responses[0] },
            { prefix: 'gh_issue_', result: responses[1] }
          ];
          for (let b = 0; b < buckets.length; b++) {
            const entry = buckets[b];
            if (entry.result.status !== 'fulfilled' || !entry.result.value.ok) continue;
            const arr = await entry.result.value.json();
            if (!Array.isArray(arr)) continue;
            for (let i = 0; i < arr.length; i++) {
              const gh = arr[i];
              if (!gh || typeof gh.body !== 'string') continue;
              const match = gh.body.match(META_REGEX);
              if (!match) continue;
              try {
                const meta = JSON.parse(match[1]);
                const ghId = entry.prefix + String(gh.id);
                // Remove any pre-post temp id matching meta.id if superseded by ghId.
                if (meta.id && byId.has(meta.id) && meta.id !== ghId) {
                  byId.delete(meta.id);
                }
                const hydrated = normalizeCommentRecord(
                  Object.assign({}, meta, {
                    id: ghId,
                    resolvedFile: gh.path || meta.resolvedFile || meta.sourceFile,
                    startLine: gh.line || meta.startLine || null,
                    comment: extractHumanBodyFromGithubComment(gh.body),
                    author: (gh.user && gh.user.login) || 'github',
                    createdAt: gh.created_at || meta.createdAt,
                    updatedAt: gh.updated_at || meta.updatedAt,
                    githubUrl: gh.html_url || '',
                    diffMatched: entry.prefix === 'gh_review_'
                  }),
                  cfg
                );
                if (hydrated) byId.set(hydrated.id, hydrated);
              } catch (_) {
                // Ignore malformed dash-review-meta JSON.
              }
            }
          }
        } catch (_) {
          // Offline or rate-limited; retain local cached preview pins.
        }
      }

      state.comments = Array.from(byId.values());
      state.anchorCache.clear();
      renderAll();
    }

    async function refreshComments() {
      if (cfg.mode === 'preview') {
        await hydratePreviewCommentsFromGithub();
        return;
      }

      if (cfg.serverOrigin) {
        try {
          const res = await fetch(cfg.serverOrigin + '/api/comments', {
            method: 'GET',
            headers: { Accept: 'application/json' }
          });
          if (res.ok) {
            const payload = await res.json();
            state.localServerOnline = true;
            if (payload && Array.isArray(payload.comments)) {
              state.comments = payload.comments
                .map(function (c) {
                  return normalizeCommentRecord(c, cfg);
                })
                .filter(Boolean);
              writeFallbackComments(state.comments);
              state.anchorCache.clear();
              renderAll();
              return;
            }
          }
        } catch (_) {
          state.localServerOnline = false;
        }
      } else {
        state.localServerOnline = false;
      }

      state.comments = readFallbackComments();
      state.anchorCache.clear();
      renderAll();
    }

    async function createComment(draft, commentText) {
      const record = normalizeCommentRecord(
        Object.assign({}, draft, {
          comment: commentText.trim(),
          status: 'open',
          createdAt: new Date().toISOString(),
          updatedAt: new Date().toISOString()
        }),
        cfg
      );

      if (cfg.mode === 'local') {
        if (cfg.serverOrigin) {
          try {
            const res = await fetch(cfg.serverOrigin + '/api/comments', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
              body: JSON.stringify(record)
            });
            if (res.ok) {
              const data = await res.json();
              state.localServerOnline = true;
              const saved = normalizeCommentRecord(data.comment || record, cfg);
              state.comments.push(saved);
              writeFallbackComments(state.comments);
              state.anchorCache.clear();
              renderAll();
              showToast('Saved to .dash_review/feedback.md (' + formatLocationChip(saved) + ')');
              return saved;
            }
          } catch (_) {
            state.localServerOnline = false;
          }
        }
        state.comments.push(record);
        writeFallbackComments(state.comments);
        state.anchorCache.clear();
        renderAll();
        showToast('Saved locally (server offline fallback)');
        return record;
      }

      // Preview mode
      const token = safeStorageGet(STORAGE_TOKEN_KEY).trim();
      if (token) {
        const result = await postCommentToGithubPr(record, token);
        state.comments.push(record);
        writeFallbackComments(state.comments);
        state.anchorCache.clear();
        renderAll();
        if (result.mode === 'inline') {
          showToast('Posted inline PR comment at ' + result.path + ':' + result.line);
        } else {
          showToast('Posted top-level PR #' + effectivePrNumber() + ' comment');
        }
        return record;
      }

      // Preview mode without token: pin locally and copy gh CLI command
      state.comments.push(record);
      writeFallbackComments(state.comments);
      state.anchorCache.clear();
      renderAll();
      await copyToClipboard(
        buildGhCliCommand(record),
        'Pinned & copied gh CLI command to clipboard'
      );
      return record;
    }

    async function toggleResolveComment(comment) {
      const nextStatus = comment.status === 'resolved' ? 'open' : 'resolved';
      if (cfg.mode === 'local' && cfg.serverOrigin) {
        try {
          const res = await fetch(
            cfg.serverOrigin + '/api/comments/' + encodeURIComponent(comment.id),
            {
              method: 'PATCH',
              headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
              body: JSON.stringify({ status: nextStatus })
            }
          );
          if (res.ok) {
            const data = await res.json();
            const updated = normalizeCommentRecord(data.comment || Object.assign({}, comment, { status: nextStatus }), cfg);
            state.comments = state.comments.map(function (c) {
              return c.id === comment.id ? updated : c;
            });
            writeFallbackComments(state.comments);
            renderAll();
            showToast(nextStatus === 'resolved' ? 'Marked comment resolved' : 'Reopened comment');
            return;
          }
        } catch (_) {
          state.localServerOnline = false;
        }
      }
      comment.status = nextStatus;
      comment.updatedAt = new Date().toISOString();
      writeFallbackComments(state.comments);
      renderAll();
      showToast(nextStatus === 'resolved' ? 'Marked comment resolved' : 'Reopened comment');
    }

    async function deleteComment(comment) {
      if (cfg.mode === 'local' && cfg.serverOrigin) {
        try {
          await fetch(cfg.serverOrigin + '/api/comments/' + encodeURIComponent(comment.id), {
            method: 'DELETE',
            headers: { Accept: 'application/json' }
          });
        } catch (_) {
          state.localServerOnline = false;
        }
      }
      state.comments = state.comments.filter(function (c) {
        return c.id !== comment.id;
      });
      if (state.activeCommentId === comment.id) {
        state.activeCommentId = null;
      }
      state.anchorCache.delete(comment.id);
      writeFallbackComments(state.comments);
      renderAll();
      showToast('Deleted comment');
    }

    async function clearResolvedComments() {
      if (cfg.mode === 'local' && cfg.serverOrigin) {
        try {
          await fetch(cfg.serverOrigin + '/api/comments?status=resolved', {
            method: 'DELETE',
            headers: { Accept: 'application/json' }
          });
        } catch (_) {
          state.localServerOnline = false;
        }
      }
      state.comments = state.comments.filter(function (c) {
        return c.status !== 'resolved';
      });
      state.anchorCache.clear();
      writeFallbackComments(state.comments);
      renderAll();
      showToast('Cleared resolved comments');
    }

    function setCommentMode(active) {
      state.commentMode = Boolean(active);
      state.hoveredEl = null;
      state.dragState = null;
      if (state.commentMode) {
        state.activeCommentId = null;
        state.composerDraft = null;
        renderComposer();
        renderThreadPopover();
        renderPinsAndHighlights();
      }
      hoverBox.classList.add('dr-hidden');
      dragBox.classList.add('dr-hidden');
      modeBanner.classList.toggle('dr-hidden', !state.commentMode);
      document.documentElement.style.cursor = state.commentMode ? 'crosshair' : '';
      renderToolbar();
    }

    function clampPopoverPosition(anchorRect, width, estHeight) {
      const vw = window.innerWidth;
      const vh = window.innerHeight;
      const baseLeft = anchorRect ? anchorRect.left : vw / 2 - width / 2;
      const left = Math.max(12, Math.min(vw - width - 12, baseLeft));
      let top = anchorRect ? anchorRect.bottom + 10 : vh / 3;
      if (top + estHeight > vh - 20 && anchorRect) {
        top = Math.max(12, anchorRect.top - estHeight - 10);
      }
      return { left: Math.round(left), top: Math.round(Math.max(12, Math.min(vh - 80, top))) };
    }

    function openComposer(draft, anchorRect) {
      state.activeCommentId = null;
      state.composerDraft = { draft: draft, anchorRect: anchorRect };
      if (state.commentMode) {
        setCommentMode(false);
      }
      renderComposer();
      renderThreadPopover();
    }

    function resolveCommentGeometry(comment) {
      let cached = state.anchorCache.get(comment.id);
      if (!cached || !cached.el || !cached.el.isConnected) {
        let targetEl = querySelectorSafe(comment.selector);
        if (!targetEl && comment.headingAnchor) {
          targetEl = querySelectorSafe(comment.headingAnchor);
        }
        if (!targetEl) {
          targetEl = document.querySelector('main, article') || document.body;
        }
        let range = null;
        if (comment.anchorType === 'text' && comment.selectedText) {
          range = locateTextRangeInElement(
            targetEl,
            comment.selectedText,
            comment.prefixContext,
            comment.suffixContext
          );
          if (!range) {
            const container = document.querySelector('main, article') || document.body;
            range = locateTextRangeInElement(
              container,
              comment.selectedText,
              comment.prefixContext,
              comment.suffixContext
            );
          }
        }
        cached = { el: targetEl, range: range };
        state.anchorCache.set(comment.id, cached);
      }

      if (cached.range) {
        const clientRects = Array.from(cached.range.getClientRects()).filter(function (r) {
          return r.width > 0 && r.height > 0;
        });
        if (clientRects.length > 0) {
          const first = clientRects[0];
          return {
            kind: 'text',
            rects: clientRects,
            pinX: first.right + 4,
            pinY: first.top,
            anchorRect: cached.range.getBoundingClientRect()
          };
        }
      }

      const baseRect = cached.el.getBoundingClientRect();
      if (baseRect.width <= 0 && baseRect.height <= 0) return null;

      if (comment.anchorType === 'area' && comment.rectPct) {
        const rx = baseRect.left + (baseRect.width * comment.rectPct.x) / 100;
        const ry = baseRect.top + (baseRect.height * comment.rectPct.y) / 100;
        const rw = Math.max(16, (baseRect.width * comment.rectPct.w) / 100);
        const rh = Math.max(16, (baseRect.height * comment.rectPct.h) / 100);
        const box = { left: rx, top: ry, width: rw, height: rh, right: rx + rw, bottom: ry + rh };
        return { kind: 'box', rects: [box], pinX: box.right, pinY: box.top, anchorRect: box };
      }

      const pinX =
        comment.rectPct && comment.rectPct.x > 0 && comment.rectPct.x < 100
          ? baseRect.left + (baseRect.width * comment.rectPct.x) / 100
          : Math.min(window.innerWidth - 20, baseRect.right - 6);
      const pinY =
        comment.rectPct && comment.rectPct.y > 0 && comment.rectPct.y < 100
          ? baseRect.top + (baseRect.height * comment.rectPct.y) / 100
          : baseRect.top + 8;
      return {
        kind: 'box',
        rects: [baseRect],
        pinX: pinX,
        pinY: pinY,
        anchorRect: baseRect
      };
    }

    function renderPinsAndHighlights() {
      clearChildren(highlightLayer);
      clearChildren(pinsContainer);
      const pageList = currentPageComments();

      for (let i = 0; i < pageList.length; i++) {
        const c = pageList[i];
        const pinNum = i + 1;
        const geom = resolveCommentGeometry(c);
        if (!geom) continue;
        const isActive = state.activeCommentId === c.id;
        const isResolved = c.status === 'resolved';

        if (geom.kind === 'text') {
          for (let r = 0; r < geom.rects.length; r++) {
            const rect = geom.rects[r];
            highlightLayer.appendChild(
              el('div', {
                className: 'dr-highlight-text',
                attrs: {
                  'data-active': isActive ? 'true' : 'false',
                  'data-resolved': isResolved ? 'true' : 'false'
                },
                style: {
                  left: Math.round(rect.left) + 'px',
                  top: Math.round(rect.top) + 'px',
                  width: Math.round(rect.width) + 'px',
                  height: Math.round(rect.height) + 'px'
                }
              })
            );
          }
        } else if (isActive || c.anchorType === 'area') {
          const rect = geom.rects[0];
          highlightLayer.appendChild(
            el('div', {
              className: 'dr-highlight-box',
              attrs: {
                'data-active': isActive ? 'true' : 'false',
                'data-resolved': isResolved ? 'true' : 'false'
              },
              style: {
                left: Math.round(rect.left) + 'px',
                top: Math.round(rect.top) + 'px',
                width: Math.round(rect.width) + 'px',
                height: Math.round(rect.height) + 'px'
              }
            })
          );
        }

        const clampedX = Math.max(14, Math.min(window.innerWidth - 14, geom.pinX));
        const clampedY = Math.max(18, Math.min(window.innerHeight - 14, geom.pinY));
        if (geom.anchorRect.bottom < 0 || geom.anchorRect.top > window.innerHeight) {
          continue;
        }

        pinsContainer.appendChild(
          el(
            'button',
            {
              className: 'dr-pin',
              text: String(pinNum),
              attrs: {
                type: 'button',
                'data-pin-number': String(pinNum),
                'data-comment-id': c.id,
                'data-active': isActive ? 'true' : 'false',
                'data-resolved': isResolved ? 'true' : 'false',
                'aria-label': 'Review comment #' + pinNum
              },
              style: {
                left: Math.round(clampedX) + 'px',
                top: Math.round(clampedY) + 'px'
              },
              on: {
                click: function (e) {
                  e.preventDefault();
                  e.stopPropagation();
                  state.composerDraft = null;
                  state.activeCommentId = state.activeCommentId === c.id ? null : c.id;
                  renderComposer();
                  renderThreadPopover();
                  renderPinsAndHighlights();
                }
              }
            }
          )
        );
      }
    }

    function renderComposer() {
      clearChildren(composerMount);
      if (!state.composerDraft) return;
      const draft = state.composerDraft.draft;
      const pos = clampPopoverPosition(state.composerDraft.anchorRect, 370, 260);
      const token = safeStorageGet(STORAGE_TOKEN_KEY).trim();
      const pr = effectivePrNumber();

      const textarea = el('textarea', {
        className: 'dr-textarea',
        attrs: {
          placeholder: 'Describe what should change... (Ctrl/Cmd+Enter to submit)',
          'aria-label': 'Review comment text',
          'data-testid': 'dr-composer-textarea'
        }
      });

      async function handleSubmit() {
        const text = textarea.value.trim();
        if (!text || state.submitting) return;
        state.submitting = true;
        renderComposer();
        try {
          const created = await createComment(draft, text);
          state.composerDraft = null;
          state.activeCommentId = created ? created.id : null;
          if (window.getSelection) {
            const sel = window.getSelection();
            if (sel && sel.removeAllRanges) sel.removeAllRanges();
          }
        } catch (err) {
          showToast(err && err.message ? err.message : 'Failed to submit comment');
        } finally {
          state.submitting = false;
          renderAll();
        }
      }

      textarea.addEventListener('keydown', function (e) {
        if ((e.metaKey || e.ctrlKey) && e.key === 'Enter') {
          e.preventDefault();
          handleSubmit();
        }
      });

      const anchorLabel =
        draft.anchorType === 'text'
          ? 'Text highlight'
          : draft.anchorType === 'area'
            ? 'Area selection'
            : 'Element <' + draft.elementTag + '>';

      const quotePreview = (draft.selectedText || draft.elementText || '').trim();
      const primaryLabel =
        cfg.mode === 'local'
          ? state.submitting
            ? 'Saving...'
            : 'Add Comment'
          : token
            ? state.submitting
              ? 'Posting...'
              : pr
                ? 'Post to PR #' + pr
                : 'Post to PR'
            : 'Pin & Copy gh CLI';

      const popover = el(
        'div',
        {
          className: 'dr-popover',
          attrs: { role: 'dialog', 'aria-label': 'New review comment', 'data-testid': 'dr-composer' },
          style: { left: pos.left + 'px', top: pos.top + 'px' }
        },
        [
          el('div', { className: 'dr-popover-header' }, [
            el('div', { className: 'dr-chip-row' }, [
              el('span', { className: 'dr-chip dr-chip-status', attrs: { 'data-status': 'open' }, text: anchorLabel }),
              draft.sourceFile ? el('span', { className: 'dr-chip', text: draft.sourceFile }) : null
            ]),
            el(
              'button',
              {
                className: 'dr-btn dr-btn-icon',
                attrs: { type: 'button', 'aria-label': 'Close composer' },
                on: {
                  click: function () {
                    state.composerDraft = null;
                    renderComposer();
                  }
                }
              },
              [icon('close', 14)]
            )
          ]),
          quotePreview
            ? el('blockquote', {
                className: 'dr-quote',
                text: quotePreview.length > 200 ? quotePreview.slice(0, 197) + '...' : quotePreview
              })
            : null,
          textarea,
          cfg.mode === 'preview' && !token
            ? el('div', {
                className: 'dr-notice',
                text: 'No GitHub token configured — save a token in Settings for 1-click inline PR diff comments, or copy the gh CLI command below.'
              })
            : null,
          el('div', { className: 'dr-popover-actions' }, [
            el('div', { className: 'dr-action-group' }, [
              cfg.mode === 'preview'
                ? el(
                    'button',
                    {
                      className: 'dr-btn dr-btn-secondary',
                      attrs: { type: 'button', 'data-testid': 'dr-composer-copy-gh' },
                      on: {
                        click: function () {
                          const temp = normalizeCommentRecord(
                            Object.assign({}, draft, {
                              comment: textarea.value.trim() || 'Review feedback'
                            }),
                            cfg
                          );
                          copyToClipboard(buildGhCliCommand(temp), 'Copied gh CLI command');
                        }
                      }
                    },
                    [icon('terminal', 13), 'Copy gh CLI Command']
                  )
                : null
            ]),
            el('div', { className: 'dr-action-group' }, [
              el(
                'button',
                {
                  className: 'dr-btn dr-btn-primary',
                  attrs: {
                    type: 'button',
                    disabled: state.submitting ? 'true' : null,
                    'data-testid': 'dr-composer-submit'
                  },
                  on: { click: handleSubmit }
                },
                [primaryLabel]
              )
            ])
          ])
        ]
      );

      composerMount.appendChild(popover);
      setTimeout(function () {
        textarea.focus();
      }, 0);
    }

    function renderThreadPopover() {
      clearChildren(threadMount);
      if (!state.activeCommentId) return;
      const pageList = currentPageComments();
      const idx = pageList.findIndex(function (c) {
        return c.id === state.activeCommentId;
      });
      const comment =
        idx !== -1
          ? pageList[idx]
          : state.comments.find(function (c) {
              return c.id === state.activeCommentId;
            });
      if (!comment) {
        state.activeCommentId = null;
        return;
      }

      const geom = resolveCommentGeometry(comment);
      const pos = clampPopoverPosition(geom ? geom.anchorRect : null, 370, 250);
      const quote = (comment.selectedText || comment.elementText || '').trim();

      const card = el(
        'div',
        {
          className: 'dr-popover',
          attrs: { role: 'dialog', 'aria-label': 'Review comment details', 'data-testid': 'dr-thread-card' },
          style: { left: pos.left + 'px', top: pos.top + 'px' }
        },
        [
          el('div', { className: 'dr-popover-header' }, [
            el('div', { className: 'dr-chip-row' }, [
              idx !== -1
                ? el('span', {
                    className: 'dr-pin-mini',
                    attrs: { 'data-resolved': comment.status === 'resolved' ? 'true' : 'false' },
                    text: '#' + (idx + 1)
                  })
                : null,
              el('span', {
                className: 'dr-chip dr-chip-status',
                attrs: { 'data-status': comment.status },
                text: comment.status === 'resolved' ? 'Resolved' : 'Open'
              }),
              el('span', {
                className: 'dr-chip',
                attrs: { title: formatLocationChip(comment) },
                text: formatLocationChip(comment)
              })
            ]),
            el(
              'button',
              {
                className: 'dr-btn dr-btn-icon',
                attrs: { type: 'button', 'aria-label': 'Close comment card' },
                on: {
                  click: function () {
                    state.activeCommentId = null;
                    renderThreadPopover();
                    renderPinsAndHighlights();
                  }
                }
              },
              [icon('close', 14)]
            )
          ]),
          quote
            ? el('blockquote', {
                className: 'dr-quote',
                text: quote.length > 180 ? quote.slice(0, 177) + '...' : quote
              })
            : null,
          el('div', { className: 'dr-comment-body', text: comment.comment }),
          el('div', { className: 'dr-meta-line' }, [
            el('span', { text: comment.author + (comment.headingAnchor ? ' · ' + comment.headingAnchor : '') }),
            comment.githubUrl
              ? el(
                  'a',
                  {
                    className: 'dr-link',
                    text: 'View on GitHub ↗',
                    attrs: { href: comment.githubUrl, target: '_blank', rel: 'noopener noreferrer' }
                  }
                )
              : null
          ]),
          el('div', { className: 'dr-popover-actions' }, [
            el('div', { className: 'dr-action-group' }, [
              el(
                'button',
                {
                  className: 'dr-btn dr-btn-secondary',
                  attrs: { type: 'button', 'data-testid': 'dr-thread-resolve' },
                  on: {
                    click: function () {
                      toggleResolveComment(comment);
                    }
                  }
                },
                [icon('check', 13), comment.status === 'resolved' ? 'Reopen' : 'Resolve']
              ),
              cfg.mode === 'preview'
                ? el(
                    'button',
                    {
                      className: 'dr-btn dr-btn-secondary',
                      attrs: { type: 'button', 'data-testid': 'dr-thread-copy-gh' },
                      on: {
                        click: function () {
                          copyToClipboard(buildGhCliCommand(comment), 'Copied gh CLI command');
                        }
                      }
                    },
                    [icon('terminal', 13), 'Copy gh CLI Command']
                  )
                : el(
                    'button',
                    {
                      className: 'dr-btn dr-btn-secondary',
                      attrs: { type: 'button', 'data-testid': 'dr-thread-copy-prompt' },
                      on: {
                        click: function () {
                          copyToClipboard(
                            formatAgentPrompt([comment]),
                            'Copied comment prompt for agent'
                          );
                        }
                      }
                    },
                    [icon('copy', 13), 'Copy Prompt']
                  )
            ]),
            el(
              'button',
              {
                className: 'dr-btn dr-btn-icon dr-btn-danger',
                attrs: { type: 'button', 'aria-label': 'Delete comment', 'data-testid': 'dr-thread-delete' },
                on: {
                  click: function () {
                    deleteComment(comment);
                  }
                }
              },
              [icon('trash', 14)]
            )
          ])
        ]
      );
      threadMount.appendChild(card);
    }

    function jumpToComment(comment) {
      if (!isCurrentPageComment(comment)) {
        const dest = String(comment.pageUrl || '/');
        if (dest.startsWith('/') && !dest.startsWith('//')) {
          try {
            window.sessionStorage.setItem('dash_review_focus_pin', comment.id);
          } catch (_) {}
          window.location.href = dest;
        }
        return;
      }
      state.activeCommentId = comment.id;
      const geom = resolveCommentGeometry(comment);
      if (geom && geom.anchorRect) {
        const targetY = window.scrollY + geom.anchorRect.top - window.innerHeight / 3;
        window.scrollTo({ top: Math.max(0, targetY), behavior: 'smooth' });
      }
      setTimeout(function () {
        renderPinsAndHighlights();
        renderThreadPopover();
      }, 220);
    }

    function renderDrawer() {
      clearChildren(drawerMount);
      if (!state.drawerOpen) return;

      const scoped =
        state.drawerScope === 'page' ? currentPageComments() : state.comments.slice();
      const openScoped = scoped.filter(function (c) {
        return c.status === 'open';
      });
      const resolvedCount = state.comments.filter(function (c) {
        return c.status === 'resolved';
      }).length;
      const filtered = scoped.filter(function (c) {
        if (state.drawerStatus === 'all') return true;
        return c.status === state.drawerStatus;
      });
      const pageComments = currentPageComments();
      const pageIndexMap = new Map();
      for (let i = 0; i < pageComments.length; i++) {
        pageIndexMap.set(pageComments[i].id, i + 1);
      }

      const drawer = el(
        'aside',
        {
          className: 'dr-drawer',
          attrs: { 'aria-label': 'Review comments drawer', 'data-testid': 'dr-drawer' }
        },
        [
          el('div', { className: 'dr-drawer-header' }, [
            el('div', { className: 'dr-drawer-title-row' }, [
              el('h2', {
                className: 'dr-drawer-title',
                text: 'Review Comments (' + filtered.length + ')'
              }),
              el(
                'button',
                {
                  className: 'dr-btn dr-btn-icon',
                  attrs: { type: 'button', 'aria-label': 'Close drawer' },
                  on: {
                    click: function () {
                      state.drawerOpen = false;
                      renderDrawer();
                      renderToolbar();
                    }
                  }
                },
                [icon('close', 15)]
              )
            ]),
            el('div', { className: 'dr-filter-bar' }, [
              el('div', { className: 'dr-segmented', attrs: { role: 'tablist' } }, [
                el(
                  'button',
                  {
                    className: 'dr-seg-btn',
                    text: 'Current Page (' + pageComments.length + ')',
                    attrs: {
                      type: 'button',
                      'aria-selected': state.drawerScope === 'page' ? 'true' : 'false'
                    },
                    on: {
                      click: function () {
                        state.drawerScope = 'page';
                        renderDrawer();
                      }
                    }
                  }
                ),
                el(
                  'button',
                  {
                    className: 'dr-seg-btn',
                    text: 'All Pages (' + state.comments.length + ')',
                    attrs: {
                      type: 'button',
                      'aria-selected': state.drawerScope === 'all' ? 'true' : 'false'
                    },
                    on: {
                      click: function () {
                        state.drawerScope = 'all';
                        renderDrawer();
                      }
                    }
                  }
                )
              ]),
              el('div', { className: 'dr-segmented', attrs: { role: 'tablist' } }, [
                el(
                  'button',
                  {
                    className: 'dr-seg-btn',
                    text: 'Open',
                    attrs: {
                      type: 'button',
                      'aria-selected': state.drawerStatus === 'open' ? 'true' : 'false'
                    },
                    on: {
                      click: function () {
                        state.drawerStatus = 'open';
                        renderDrawer();
                      }
                    }
                  }
                ),
                el(
                  'button',
                  {
                    className: 'dr-seg-btn',
                    text: 'Resolved',
                    attrs: {
                      type: 'button',
                      'aria-selected': state.drawerStatus === 'resolved' ? 'true' : 'false'
                    },
                    on: {
                      click: function () {
                        state.drawerStatus = 'resolved';
                        renderDrawer();
                      }
                    }
                  }
                )
              ])
            ]),
            el('div', { className: 'dr-drawer-toolbar' }, [
              el(
                'button',
                {
                  className: 'dr-btn dr-btn-primary',
                  attrs: { type: 'button', 'data-testid': 'dr-copy-prompt-agent' },
                  on: {
                    click: function () {
                      const targetList =
                        openScoped.length > 0
                          ? openScoped
                          : state.comments.filter(function (c) {
                              return c.status === 'open';
                            });
                      copyToClipboard(
                        formatAgentPrompt(targetList),
                        'Copied structured prompt for agent (' + targetList.length + ' comments)'
                      );
                    }
                  }
                },
                [icon('copy', 13), 'Copy Prompt for Agent']
              ),
              resolvedCount > 0
                ? el(
                    'button',
                    {
                      className: 'dr-btn dr-btn-secondary',
                      attrs: { type: 'button', 'data-testid': 'dr-clear-resolved' },
                      on: { click: clearResolvedComments }
                    },
                    ['Clear Resolved (' + resolvedCount + ')']
                  )
                : null
            ])
          ]),
          el(
            'div',
            { className: 'dr-drawer-list' },
            filtered.length === 0
              ? [
                  el('div', {
                    className: 'dr-empty',
                    text:
                      state.drawerStatus === 'open'
                        ? 'No open comments here yet. Select any text on the page or press Alt+C to pin an element.'
                        : 'No resolved comments.'
                  })
                ]
              : filtered.map(function (c) {
                  const pinNo = pageIndexMap.get(c.id);
                  const quote = (c.selectedText || c.elementText || '').trim();
                  return el(
                    'div',
                    {
                      className: 'dr-card',
                      attrs: { 'data-comment-id': c.id },
                      on: {
                        click: function () {
                          jumpToComment(c);
                        }
                      }
                    },
                    [
                      el('div', { className: 'dr-card-top' }, [
                        el('div', { className: 'dr-chip-row' }, [
                          pinNo
                            ? el('span', {
                                className: 'dr-pin-mini',
                                attrs: { 'data-resolved': c.status === 'resolved' ? 'true' : 'false' },
                                text: String(pinNo)
                              })
                            : null,
                          el('span', { className: 'dr-chip', text: formatLocationChip(c) }),
                          !isCurrentPageComment(c)
                            ? el('span', { className: 'dr-chip', text: c.pageUrl })
                            : null
                        ]),
                        el('div', { className: 'dr-action-group' }, [
                          el(
                            'button',
                            {
                              className: 'dr-btn dr-btn-secondary',
                              style: { padding: '3px 8px', fontSize: '11px' },
                              attrs: { type: 'button' },
                              on: {
                                click: function (e) {
                                  e.stopPropagation();
                                  toggleResolveComment(c);
                                }
                              }
                            },
                            [c.status === 'resolved' ? 'Reopen' : 'Resolve']
                          )
                        ])
                      ]),
                      quote
                        ? el('blockquote', {
                            className: 'dr-quote',
                            text: quote.length > 120 ? quote.slice(0, 117) + '...' : quote
                          })
                        : null,
                      el('div', { className: 'dr-comment-body', text: c.comment })
                    ]
                  );
                })
          )
        ]
      );

      drawerMount.appendChild(drawer);
    }

    function renderSettingsModal() {
      clearChildren(modalMount);
      if (!state.settingsOpen) return;

      const authorInput = el('input', {
        className: 'dr-input',
        attrs: {
          type: 'text',
          value: safeStorageGet(STORAGE_AUTHOR_KEY) || 'reviewer',
          placeholder: 'reviewer'
        }
      });

      const statusBox = el('div', { className: 'dr-status-box' });

      let tokenInput = null;
      let repoInput = null;
      let prInput = null;

      if (cfg.mode === 'preview') {
        tokenInput = el('input', {
          className: 'dr-input',
          attrs: {
            type: 'password',
            value: safeStorageGet(STORAGE_TOKEN_KEY),
            placeholder: 'github_pat_... or ghp_...',
            'aria-label': 'GitHub Personal Access Token',
            'data-testid': 'dr-settings-token'
          }
        });
        repoInput = el('input', {
          className: 'dr-input',
          attrs: {
            type: 'text',
            value: effectiveRepo(),
            placeholder: 'flutter/website',
            'aria-label': 'GitHub Repository'
          }
        });
        prInput = el('input', {
          className: 'dr-input',
          attrs: {
            type: 'text',
            value: effectivePrNumber(),
            placeholder: 'e.g. 14030',
            'aria-label': 'Pull Request Number',
            'data-testid': 'dr-settings-pr'
          }
        });
        statusBox.textContent = safeStorageGet(STORAGE_TOKEN_KEY)
          ? 'GitHub token saved in browser localStorage.'
          : 'Configure a token (Pull requests: Read & Write) for direct inline PR comments, or use Copy gh CLI Command without a token.';
      } else {
        statusBox.textContent = cfg.serverOrigin
          ? 'Checking local sync server at ' + cfg.serverOrigin + '...'
          : 'No local review server configured (using browser localStorage fallback).';
        if (cfg.serverOrigin) {
          fetch(cfg.serverOrigin + '/api/health')
            .then(function (r) {
              return r.ok ? r.json() : Promise.reject(new Error('HTTP ' + r.status));
            })
            .then(function (info) {
              state.localServerOnline = true;
              statusBox.setAttribute('data-ok', 'true');
              clearChildren(statusBox);
              statusBox.appendChild(
                el('strong', { text: 'Connected to local sync server (' + cfg.serverOrigin + ')' })
              );
              statusBox.appendChild(
                el('span', {
                  text: 'Feedback file: ' + (info.feedbackFile || '.dash_review/feedback.md')
                })
              );
              renderToolbar();
            })
            .catch(function () {
              state.localServerOnline = false;
              statusBox.setAttribute('data-error', 'true');
              statusBox.textContent =
                'Local server unreachable at ' +
                cfg.serverOrigin +
                ' — falling back to localStorage.';
              renderToolbar();
            });
        }
      }

      async function testGithubConnection() {
        const tok = tokenInput.value.trim();
        const repoVal = repoInput.value.trim() || 'flutter/website';
        const prVal = prInput.value.trim();
        statusBox.removeAttribute('data-ok');
        statusBox.removeAttribute('data-error');
        statusBox.textContent = 'Testing GitHub API connection...';
        try {
          const api = githubApiBase();
          const url = prVal
            ? api + '/repos/' + repoVal + '/pulls/' + prVal
            : api + '/repos/' + repoVal;
          const res = await fetch(url, { headers: githubHeaders(tok) });
          if (!res.ok) {
            throw new Error('HTTP ' + res.status);
          }
          const data = await res.json();
          statusBox.setAttribute('data-ok', 'true');
          statusBox.textContent = prVal
            ? 'Connected to ' +
              repoVal +
              ' PR #' +
              prVal +
              (data.head && data.head.sha ? ' (HEAD ' + String(data.head.sha).slice(0, 7) + ')' : '')
            : 'Connected to ' + repoVal;
        } catch (err) {
          statusBox.setAttribute('data-error', 'true');
          statusBox.textContent =
            'Connection failed (' + (err && err.message ? err.message : 'network error') + ').';
        }
      }

      function saveSettings() {
        safeStorageSet(STORAGE_AUTHOR_KEY, authorInput.value.trim() || 'reviewer');
        if (cfg.mode === 'preview') {
          safeStorageSet(STORAGE_TOKEN_KEY, tokenInput.value.trim());
          safeStorageSet(STORAGE_REPO_KEY, repoInput.value.trim());
          safeStorageSet(STORAGE_PR_KEY, prInput.value.trim());
          state.prFilesCache.clear();
          state.prMetaCache.clear();
          hydratePreviewCommentsFromGithub();
        }
        state.settingsOpen = false;
        renderSettingsModal();
        renderToolbar();
        showToast('Saved review settings');
      }

      const backdrop = el(
        'div',
        {
          className: 'dr-modal-backdrop',
          attrs: { 'data-testid': 'dr-settings-modal' },
          on: {
            click: function (e) {
              if (e.target === backdrop) {
                state.settingsOpen = false;
                renderSettingsModal();
              }
            }
          }
        },
        [
          el(
            'div',
            { className: 'dr-modal', attrs: { role: 'dialog', 'aria-label': 'Review Settings' } },
            [
              el('div', { className: 'dr-popover-header' }, [
                el('h2', {
                  className: 'dr-drawer-title',
                  text: cfg.mode === 'preview' ? 'PR Preview Review Settings' : 'Local Review Sync Settings'
                }),
                el(
                  'button',
                  {
                    className: 'dr-btn dr-btn-icon',
                    attrs: { type: 'button', 'aria-label': 'Close settings' },
                    on: {
                      click: function () {
                        state.settingsOpen = false;
                        renderSettingsModal();
                      }
                    }
                  },
                  [icon('close', 15)]
                )
              ]),
              statusBox,
              cfg.mode === 'preview'
                ? el('div', { className: 'dr-field' }, [
                    el('label', { className: 'dr-label', text: 'GitHub Personal Access Token' }),
                    tokenInput,
                    el('span', {
                      className: 'dr-help',
                      text: 'Stored only in your browser localStorage (dash_review_gh_token). Fine-grained PAT with Pull requests: Read and write.'
                    })
                  ])
                : el('div', { className: 'dr-field' }, [
                    el('label', { className: 'dr-label', text: 'Agent Feedback Sync Path' }),
                    el('div', { className: 'dr-chip', text: '.dash_review/feedback.md' }),
                    el('span', {
                      className: 'dr-help',
                      text: 'Every comment updates .dash_review/comments.json and .dash_review/feedback.md for coding agents.'
                    })
                  ]),
              cfg.mode === 'preview'
                ? el('div', { style: { display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '10px' } }, [
                    el('div', { className: 'dr-field' }, [
                      el('label', { className: 'dr-label', text: 'Repository' }),
                      repoInput
                    ]),
                    el('div', { className: 'dr-field' }, [
                      el('label', { className: 'dr-label', text: 'PR Number' }),
                      prInput
                    ])
                  ])
                : null,
              el('div', { className: 'dr-field' }, [
                el('label', { className: 'dr-label', text: 'Reviewer Name' }),
                authorInput
              ]),
              el('div', { className: 'dr-popover-actions' }, [
                el('div', { className: 'dr-action-group' }, [
                  cfg.mode === 'preview'
                    ? el(
                        'button',
                        {
                          className: 'dr-btn dr-btn-secondary',
                          attrs: { type: 'button', 'data-testid': 'dr-settings-test' },
                          on: { click: testGithubConnection }
                        },
                        ['Test Connection']
                      )
                    : null
                ]),
                el('div', { className: 'dr-action-group' }, [
                  el(
                    'button',
                    {
                      className: 'dr-btn dr-btn-primary',
                      attrs: { type: 'button', 'data-testid': 'dr-settings-save' },
                      on: { click: saveSettings }
                    },
                    ['Save Settings']
                  )
                ])
              ])
            ]
          )
        ]
      );

      modalMount.appendChild(backdrop);
    }

    function renderToolbar() {
      clearChildren(toolbarMount);
      const pr = effectivePrNumber();
      const badgeText =
        cfg.mode === 'local'
          ? 'LOCAL REVIEW'
          : pr
            ? 'PR #' + pr + ' PREVIEW'
            : 'PR PREVIEW';
      const openTotal = state.comments.filter(function (c) {
        return c.status === 'open';
      }).length;
      const openPage = currentPageComments().filter(function (c) {
        return c.status === 'open';
      }).length;

      if (state.collapsed) {
        toolbarMount.appendChild(
          el(
            'div',
            {
              className: 'dr-toolbar',
              attrs: { role: 'toolbar', 'aria-label': 'Visual review toolbar', 'data-testid': 'dr-toolbar' }
            },
            [
              el(
                'button',
                {
                  className: 'dr-btn',
                  attrs: { type: 'button', 'aria-label': 'Expand review toolbar' },
                  on: {
                    click: function () {
                      state.collapsed = false;
                      renderToolbar();
                    }
                  }
                },
                [
                  el('span', {
                    className: 'dr-mode-badge',
                    attrs: { 'data-mode': cfg.mode },
                    text: badgeText
                  }),
                  openTotal > 0 ? el('span', { className: 'dr-count-pill', text: String(openTotal) }) : null,
                  icon('expand', 14)
                ]
              )
            ]
          )
        );
        return;
      }

      toolbarMount.appendChild(
        el(
          'div',
          {
            className: 'dr-toolbar',
            attrs: { role: 'toolbar', 'aria-label': 'Visual review toolbar', 'data-testid': 'dr-toolbar' }
          },
          [
            el(
              'span',
              {
                className: 'dr-mode-badge',
                attrs: { 'data-mode': cfg.mode, 'data-testid': 'dr-mode-badge' }
              },
              [
                el('span', {
                  className: 'dr-status-dot',
                  attrs: {
                    'data-offline':
                      cfg.mode === 'local' && !state.localServerOnline ? 'true' : 'false'
                  }
                }),
                badgeText
              ]
            ),
            el('span', { className: 'dr-divider' }),
            el(
              'button',
              {
                className: 'dr-btn',
                attrs: {
                  type: 'button',
                  'aria-pressed': state.commentMode ? 'true' : 'false',
                  'aria-label': 'Toggle comment mode (Alt+C)',
                  title: 'Comment on element or region (Alt+C)',
                  'data-testid': 'dr-toggle-comment-mode'
                },
                on: {
                  click: function () {
                    setCommentMode(!state.commentMode);
                  }
                }
              },
              [icon('crosshair', 14), state.commentMode ? 'Commenting' : 'Comment']
            ),
            el(
              'button',
              {
                className: 'dr-btn',
                attrs: {
                  type: 'button',
                  'aria-pressed': state.drawerOpen ? 'true' : 'false',
                  'aria-label': 'Open review comments drawer',
                  'data-testid': 'dr-toggle-drawer'
                },
                on: {
                  click: function () {
                    state.drawerOpen = !state.drawerOpen;
                    renderDrawer();
                    renderToolbar();
                  }
                }
              },
              [
                icon('list', 14),
                'Comments',
                el('span', {
                  className: 'dr-count-pill',
                  text: String(openPage || openTotal)
                })
              ]
            ),
            openTotal > 0 && cfg.mode === 'local'
              ? el(
                  'button',
                  {
                    className: 'dr-btn',
                    attrs: {
                      type: 'button',
                      title: 'Copy structured Markdown prompt for coding agent',
                      'data-testid': 'dr-toolbar-copy-prompt'
                    },
                    on: {
                      click: function () {
                        const openItems = state.comments.filter(function (c) {
                          return c.status === 'open';
                        });
                        copyToClipboard(
                          formatAgentPrompt(openItems),
                          'Copied prompt for agent (' + openItems.length + ' open)'
                        );
                      }
                    }
                  },
                  [icon('copy', 13), 'Copy Prompt']
                )
              : null,
            el(
              'button',
              {
                className: 'dr-btn dr-btn-icon',
                attrs: {
                  type: 'button',
                  'aria-label': 'Review settings',
                  title: 'Review settings',
                  'data-testid': 'dr-open-settings'
                },
                on: {
                  click: function () {
                    state.settingsOpen = !state.settingsOpen;
                    renderSettingsModal();
                  }
                }
              },
              [icon('settings', 15)]
            ),
            el(
              'button',
              {
                className: 'dr-btn dr-btn-icon',
                attrs: {
                  type: 'button',
                  'aria-label': 'Collapse review toolbar',
                  title: 'Minimize toolbar'
                },
                on: {
                  click: function () {
                    state.collapsed = true;
                    renderToolbar();
                  }
                }
              },
              [icon('minimize', 14)]
            )
          ]
        )
      );
    }

    function renderAll() {
      renderToolbar();
      renderPinsAndHighlights();
      renderComposer();
      renderThreadPopover();
      renderDrawer();
      renderSettingsModal();
    }

    function pickInspectableElement(clientX, clientY) {
      const hit = document.elementFromPoint(clientX, clientY);
      if (!hit || hit === document.documentElement || hit === document.body) return null;
      if (hit === host || hit.closest('#dash-review-host,[data-dash-review-ignore="true"]')) {
        return null;
      }
      return hit;
    }

    function buildDraftFromElement(targetEl, anchorType, rectPct) {
      const tag = targetEl.tagName ? targetEl.tagName.toLowerCase() : 'div';
      const rawText = (targetEl.innerText || targetEl.textContent || '')
        .replace(/\s+/g, ' ')
        .trim()
        .slice(0, 240);
      return {
        site: cfg.site,
        pageUrl: cfg.pageUrl,
        pageTitle: cfg.pageTitle,
        sourceFile: cfg.sourceFile,
        anchorType: anchorType,
        selectedText: '',
        prefixContext: '',
        suffixContext: '',
        selector: buildElementSelector(targetEl),
        elementTag: tag,
        elementText: rawText,
        headingAnchor: findNearestHeadingAnchor(targetEl),
        rectPct: rectPct
      };
    }

    // Comment Mode mouse interactions
    document.addEventListener(
      'mousemove',
      function (e) {
        if (!state.commentMode) return;
        if (state.dragState) {
          const dx = Math.abs(e.clientX - state.dragState.startX);
          const dy = Math.abs(e.clientY - state.dragState.startY);
          if (dx >= 12 || dy >= 12) {
            state.dragState.isArea = true;
            hoverBox.classList.add('dr-hidden');
            const left = Math.min(state.dragState.startX, e.clientX);
            const top = Math.min(state.dragState.startY, e.clientY);
            const width = Math.max(4, dx);
            const height = Math.max(4, dy);
            dragBox.classList.remove('dr-hidden');
            dragBox.style.left = Math.round(left) + 'px';
            dragBox.style.top = Math.round(top) + 'px';
            dragBox.style.width = Math.round(width) + 'px';
            dragBox.style.height = Math.round(height) + 'px';
          }
          return;
        }
        if (isReviewEvent(e)) {
          hoverBox.classList.add('dr-hidden');
          return;
        }
        const target = pickInspectableElement(e.clientX, e.clientY);
        if (!target) {
          hoverBox.classList.add('dr-hidden');
          return;
        }
        state.hoveredEl = target;
        const rect = target.getBoundingClientRect();
        const heading = findNearestHeadingAnchor(target);
        hoverLabel.textContent = target.tagName.toLowerCase() + (heading ? ' · ' + heading : '');
        hoverBox.style.left = Math.round(rect.left) + 'px';
        hoverBox.style.top = Math.round(rect.top) + 'px';
        hoverBox.style.width = Math.round(rect.width) + 'px';
        hoverBox.style.height = Math.round(rect.height) + 'px';
        hoverBox.classList.remove('dr-hidden');
      },
      true
    );

    document.addEventListener(
      'mousedown',
      function (e) {
        if (!state.commentMode || e.button !== 0 || isReviewEvent(e)) return;
        const target = pickInspectableElement(e.clientX, e.clientY);
        if (!target) return;
        e.preventDefault();
        e.stopPropagation();
        state.dragState = {
          startX: e.clientX,
          startY: e.clientY,
          target: target,
          isArea: false
        };
      },
      true
    );

    document.addEventListener(
      'mouseup',
      function (e) {
        if (state.commentMode && state.dragState && e.button === 0) {
          const ds = state.dragState;
          state.dragState = null;
          dragBox.classList.add('dr-hidden');
          hoverBox.classList.add('dr-hidden');
          state.justConsumedClickUntil = Date.now() + 400;
          e.preventDefault();
          e.stopPropagation();

          if (ds.isArea) {
            const left = Math.min(ds.startX, e.clientX);
            const top = Math.min(ds.startY, e.clientY);
            const width = Math.max(16, Math.abs(e.clientX - ds.startX));
            const height = Math.max(16, Math.abs(e.clientY - ds.startY));
            const centerEl =
              pickInspectableElement(left + width / 2, top + height / 2) ||
              ds.target ||
              document.querySelector('main, article') ||
              document.body;
            let container = centerEl;
            while (
              container.parentElement &&
              container.parentElement !== document.body &&
              container.getBoundingClientRect().width < width
            ) {
              container = container.parentElement;
            }
            const cRect = container.getBoundingClientRect();
            const rectPct = {
              x: roundPct(((left - cRect.left) / Math.max(1, cRect.width)) * 100),
              y: roundPct(((top - cRect.top) / Math.max(1, cRect.height)) * 100),
              w: roundPct((width / Math.max(1, cRect.width)) * 100),
              h: roundPct((height / Math.max(1, cRect.height)) * 100)
            };
            const draft = buildDraftFromElement(container, 'area', rectPct);
            openComposer(draft, {
              left: left,
              top: top,
              right: left + width,
              bottom: top + height,
              width: width,
              height: height
            });
            return;
          }

          const elRect = ds.target.getBoundingClientRect();
          const rectPct = {
            x: roundPct(((e.clientX - elRect.left) / Math.max(1, elRect.width)) * 100),
            y: roundPct(((e.clientY - elRect.top) / Math.max(1, elRect.height)) * 100),
            w: 100,
            h: 100
          };
          const draft = buildDraftFromElement(ds.target, 'element', rectPct);
          openComposer(draft, elRect);
        }
      },
      true
    );

    document.addEventListener(
      'click',
      function (e) {
        if (Date.now() < state.justConsumedClickUntil && !isReviewEvent(e)) {
          e.preventDefault();
          e.stopPropagation();
        }
      },
      true
    );

    // Native text-selection detector (works anytime without toggling Comment Mode!)
    let selectionTimer = null;
    function checkTextSelection() {
      if (state.commentMode || state.composerDraft) {
        selectionPill.classList.add('dr-hidden');
        return;
      }
      const sel = window.getSelection ? window.getSelection() : null;
      if (!sel || sel.isCollapsed || sel.rangeCount === 0) {
        state.pendingSelection = null;
        selectionPill.classList.add('dr-hidden');
        return;
      }
      const rawSelected = sel.toString();
      const selectedText = rawSelected.trim();
      if (selectedText.length < 2) {
        state.pendingSelection = null;
        selectionPill.classList.add('dr-hidden');
        return;
      }
      const range = sel.getRangeAt(0);
      const common =
        range.commonAncestorContainer.nodeType === 1
          ? range.commonAncestorContainer
          : range.commonAncestorContainer.parentElement;
      if (
        !common ||
        common === host ||
        common.closest('#dash-review-host,[data-dash-review-ignore="true"],input,textarea,[contenteditable="true"]')
      ) {
        state.pendingSelection = null;
        selectionPill.classList.add('dr-hidden');
        return;
      }

      const rect = range.getBoundingClientRect();
      if (rect.width <= 0 && rect.height <= 0) {
        selectionPill.classList.add('dr-hidden');
        return;
      }

      // Extract 30-char prefix & suffix context around the selection inside block container.
      const fullBlockText = common.textContent || '';
      let prefixContext = '';
      let suffixContext = '';
      try {
        const preRange = document.createRange();
        preRange.selectNodeContents(common);
        preRange.setEnd(range.startContainer, range.startOffset);
        const beforeStr = preRange.toString();
        prefixContext = beforeStr.slice(Math.max(0, beforeStr.length - 30));
        const afterStart = beforeStr.length + rawSelected.length;
        suffixContext = fullBlockText.slice(afterStart, afterStart + 30);
      } catch (_) {
        const idx = fullBlockText.indexOf(selectedText);
        if (idx !== -1) {
          prefixContext = fullBlockText.slice(Math.max(0, idx - 30), idx);
          suffixContext = fullBlockText.slice(
            idx + selectedText.length,
            idx + selectedText.length + 30
          );
        }
      }

      const cRect = common.getBoundingClientRect();
      const rectPct = {
        x: roundPct(((rect.left - cRect.left) / Math.max(1, cRect.width)) * 100),
        y: roundPct(((rect.top - cRect.top) / Math.max(1, cRect.height)) * 100),
        w: roundPct((rect.width / Math.max(1, cRect.width)) * 100),
        h: roundPct((rect.height / Math.max(1, cRect.height)) * 100)
      };

      state.pendingSelection = {
        anchorRect: rect,
        draft: {
          site: cfg.site,
          pageUrl: cfg.pageUrl,
          pageTitle: cfg.pageTitle,
          sourceFile: cfg.sourceFile,
          anchorType: 'text',
          selectedText: selectedText,
          prefixContext: prefixContext,
          suffixContext: suffixContext,
          selector: buildElementSelector(common),
          elementTag: common.tagName.toLowerCase(),
          elementText: fullBlockText.replace(/\s+/g, ' ').trim().slice(0, 240),
          headingAnchor: findNearestHeadingAnchor(common),
          rectPct: rectPct
        }
      };

      const pillLeft = Math.max(90, Math.min(window.innerWidth - 90, rect.left + rect.width / 2));
      const rawPillTop = rect.top >= 46 ? rect.top - 38 : rect.bottom + 8;
      const pillTop = Math.max(12, Math.min(window.innerHeight - 48, rawPillTop));
      selectionPill.style.left = Math.round(pillLeft) + 'px';
      selectionPill.style.top = Math.round(pillTop) + 'px';
      selectionPill.classList.remove('dr-hidden');
    }

    let pointerDownOutside = false;
    document.addEventListener(
      'mousedown',
      function (e) {
        if (!isReviewEvent(e)) pointerDownOutside = true;
      },
      true
    );
    document.addEventListener('mouseup', function (e) {
      pointerDownOutside = false;
      if (isReviewEvent(e)) return;
      clearTimeout(selectionTimer);
      selectionTimer = setTimeout(checkTextSelection, 60);
    });
    document.addEventListener('keyup', function (e) {
      if (isReviewEvent(e)) return;
      clearTimeout(selectionTimer);
      selectionTimer = setTimeout(checkTextSelection, 80);
    });
    document.addEventListener('selectionchange', function () {
      const sel = window.getSelection ? window.getSelection() : null;
      clearTimeout(selectionTimer);
      if (!sel || sel.isCollapsed) {
        selectionTimer = setTimeout(function () {
          const cur = window.getSelection ? window.getSelection() : null;
          if (!cur || cur.isCollapsed) {
            state.pendingSelection = null;
            selectionPill.classList.add('dr-hidden');
          }
        }, 120);
      } else if (!pointerDownOutside) {
        selectionTimer = setTimeout(checkTextSelection, 100);
      }
    });

    // Keyboard shortcuts: Alt+C toggles Comment Mode; Escape cancels active UI.
    document.addEventListener('keydown', function (e) {
      if (e.altKey && !e.ctrlKey && !e.metaKey && (e.code === 'KeyC' || e.key === 'c' || e.key === 'C')) {
        e.preventDefault();
        setCommentMode(!state.commentMode);
        return;
      }
      if (e.key === 'Escape') {
        if (state.dragState) {
          state.dragState = null;
          dragBox.classList.add('dr-hidden');
        } else if (state.composerDraft) {
          state.composerDraft = null;
          renderComposer();
        } else if (state.activeCommentId) {
          state.activeCommentId = null;
          renderThreadPopover();
          renderPinsAndHighlights();
        } else if (state.settingsOpen) {
          state.settingsOpen = false;
          renderSettingsModal();
        } else if (state.commentMode) {
          setCommentMode(false);
        } else if (state.drawerOpen) {
          state.drawerOpen = false;
          renderDrawer();
          renderToolbar();
        }
      }
    });

    // Smooth pin & highlight repositioning on scroll and resize
    let rafPending = false;
    function scheduleGeometryUpdate() {
      if (rafPending) return;
      rafPending = true;
      window.requestAnimationFrame(function () {
        rafPending = false;
        renderPinsAndHighlights();
        if (state.pendingSelection) {
          checkTextSelection();
        }
      });
    }
    window.addEventListener('scroll', scheduleGeometryUpdate, { capture: true, passive: true });
    window.addEventListener('resize', scheduleGeometryUpdate, { passive: true });

    // Auto-refresh on focus/visibilitychange in local mode so agent CLI resolves reflect immediately!
    window.addEventListener('focus', function () {
      if (cfg.mode === 'local') refreshComments();
    });
    document.addEventListener('visibilitychange', function () {
      if (document.visibilityState === 'visible' && cfg.mode === 'local') {
        refreshComments();
      }
    });

    renderAll();
    refreshComments().then(function () {
      try {
        const focusId = window.sessionStorage.getItem('dash_review_focus_pin');
        if (focusId) {
          window.sessionStorage.removeItem('dash_review_focus_pin');
          const target = state.comments.find(function (c) {
            return c.id === focusId;
          });
          if (target) jumpToComment(target);
        }
      } catch (_) {}
    });
  }

  window.__dashReviewInternals = {
    parsePrFromHostname: parsePrFromHostname,
    shellQuote: shellQuote,
    parseDiffRightSideLines: parseDiffRightSideLines,
    matchNeedleInRightLines: matchNeedleInRightLines,
    matchNeedleInFullText: matchNeedleInFullText,
    normalizePageUrl: normalizePageUrl,
    stripMarkdownInline: stripMarkdownInline
  };

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', mountOverlay, { once: true });
  } else {
    mountOverlay();
  }
})();
''';
