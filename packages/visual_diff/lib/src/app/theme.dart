// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// CSS variables and stylesheets for the Argos-inspired Visual Diff viewer.
const String visualDiffStyles = r'''
:root {
  --vd-font: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
  --vd-font-mono: ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace;

  /* Dark Theme (Default Argos-inspired palette) */
  --vd-bg: #0d1117;
  --vd-bg-secondary: #161b22;
  --vd-bg-tertiary: #21262d;
  --vd-surface: #161b22;
  --vd-surface-hover: #1c2128;
  --vd-surface-active: #282e36;
  --vd-border: #30363d;
  --vd-border-subtle: #21262d;
  
  --vd-text-primary: #f0f6fc;
  --vd-text-secondary: #8b949e;
  --vd-text-muted: #6e7681;

  --vd-accent: #2f81f7;
  --vd-accent-hover: #388bfd;
  --vd-accent-subtle: rgba(56, 139, 253, 0.15);

  --vd-badge-changed-bg: rgba(210, 153, 34, 0.15);
  --vd-badge-changed-text: #e3b341;
  --vd-badge-changed-border: rgba(210, 153, 34, 0.4);

  --vd-badge-added-bg: rgba(46, 160, 67, 0.15);
  --vd-badge-added-text: #3fb950;
  --vd-badge-added-border: rgba(46, 160, 67, 0.4);

  --vd-badge-removed-bg: rgba(248, 81, 73, 0.15);
  --vd-badge-removed-text: #f85149;
  --vd-badge-removed-border: rgba(248, 81, 73, 0.4);

  --vd-badge-unchanged-bg: rgba(110, 118, 129, 0.15);
  --vd-badge-unchanged-text: #8b949e;
  --vd-badge-unchanged-border: rgba(110, 118, 129, 0.3);

  --vd-diff-highlight: #ff007a;
  --vd-header-height: 56px;
  --vd-sidebar-width: 380px;
}

[data-theme="light"] {
  --vd-bg: #f6f8fa;
  --vd-bg-secondary: #ffffff;
  --vd-bg-tertiary: #eaeef2;
  --vd-surface: #ffffff;
  --vd-surface-hover: #f3f4f6;
  --vd-surface-active: #e5e7eb;
  --vd-border: #d0d7de;
  --vd-border-subtle: #e1e4e8;

  --vd-text-primary: #1f2328;
  --vd-text-secondary: #656d76;
  --vd-text-muted: #8c959f;

  --vd-accent: #0969da;
  --vd-accent-hover: #0860ca;
  --vd-accent-subtle: rgba(9, 105, 218, 0.1);

  --vd-badge-changed-bg: #fff8c5;
  --vd-badge-changed-text: #9a6700;
  --vd-badge-changed-border: rgba(212, 167, 44, 0.4);

  --vd-badge-added-bg: #dafbe1;
  --vd-badge-added-text: #1a7f37;
  --vd-badge-added-border: rgba(74, 194, 107, 0.4);

  --vd-badge-removed-bg: #ffebe9;
  --vd-badge-removed-text: #cf222e;
  --vd-badge-removed-border: rgba(255, 129, 130, 0.4);

  --vd-badge-unchanged-bg: #f3f4f6;
  --vd-badge-unchanged-text: #656d76;
  --vd-badge-unchanged-border: #d0d7de;
}

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: var(--vd-font);
  background-color: var(--vd-bg);
  color: var(--vd-text-primary);
  overflow: hidden;
  height: 100vh;
  width: 100vw;
  user-select: none;
}

/* App Layout */
.vd-app {
  display: flex;
  flex-direction: column;
  height: 100vh;
  width: 100vw;
}

/* Header */
.vd-header {
  height: var(--vd-header-height);
  background-color: var(--vd-bg-secondary);
  border-bottom: 1px solid var(--vd-border);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  flex-shrink: 0;
  gap: 16px;
  z-index: 100;
}

.vd-brand {
  display: flex;
  align-items: center;
  gap: 10px;
  font-weight: 600;
  font-size: 15px;
  letter-spacing: -0.2px;
}

.vd-brand-badge {
  background: linear-gradient(135deg, #0468D7, #833ef2);
  color: white;
  font-size: 11px;
  font-weight: 700;
  padding: 2px 7px;
  border-radius: 12px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.vd-header-center {
  display: flex;
  align-items: center;
  gap: 8px;
}

.vd-mode-pills {
  display: flex;
  background-color: var(--vd-bg-tertiary);
  padding: 3px;
  border-radius: 8px;
  border: 1px solid var(--vd-border);
}

.vd-mode-btn {
  background: transparent;
  border: none;
  color: var(--vd-text-secondary);
  padding: 5px 12px;
  border-radius: 6px;
  font-size: 12px;
  font-weight: 500;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 6px;
  transition: all 0.15s ease;
}

.vd-mode-btn:hover {
  color: var(--vd-text-primary);
}

.vd-mode-btn.active {
  background-color: var(--vd-surface);
  color: var(--vd-text-primary);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
}

.vd-mode-key {
  font-family: var(--vd-font-mono);
  font-size: 10px;
  opacity: 0.6;
  background: var(--vd-bg-tertiary);
  padding: 1px 4px;
  border-radius: 3px;
}

.vd-header-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

.vd-icon-btn {
  background: transparent;
  border: 1px solid var(--vd-border);
  color: var(--vd-text-secondary);
  width: 32px;
  height: 32px;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.15s ease;
}

.vd-icon-btn:hover {
  background-color: var(--vd-surface-hover);
  color: var(--vd-text-primary);
  border-color: var(--vd-text-muted);
}

/* Main Body Layout */
.vd-body {
  display: flex;
  flex: 1;
  overflow: hidden;
}

/* Sidebar */
.vd-sidebar {
  width: var(--vd-sidebar-width);
  background-color: var(--vd-bg-secondary);
  border-right: 1px solid var(--vd-border);
  display: flex;
  flex-direction: column;
  flex-shrink: 0;
  overflow: hidden;
}

.vd-sidebar-search {
  padding: 12px 14px;
  border-bottom: 1px solid var(--vd-border);
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.vd-search-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}

.vd-search-input {
  width: 100%;
  background-color: var(--vd-bg-tertiary);
  border: 1px solid var(--vd-border);
  border-radius: 6px;
  padding: 7px 10px 7px 28px;
  font-size: 12px;
  color: var(--vd-text-primary);
  outline: none;
  font-family: var(--vd-font);
}

.vd-search-input:focus {
  border-color: var(--vd-accent);
}

.vd-search-icon {
  position: absolute;
  left: 9px;
  font-size: 12px;
  color: var(--vd-text-muted);
  pointer-events: none;
}

.vd-status-filters {
  display: flex;
  gap: 6px;
  overflow-x: auto;
  padding-bottom: 2px;
}

.vd-filter-pill {
  background: var(--vd-bg-tertiary);
  border: 1px solid transparent;
  color: var(--vd-text-secondary);
  font-size: 11px;
  padding: 3px 8px;
  border-radius: 12px;
  cursor: pointer;
  white-space: nowrap;
  display: flex;
  align-items: center;
  gap: 5px;
  font-weight: 500;
}

.vd-filter-pill:hover {
  color: var(--vd-text-primary);
}

.vd-filter-pill.active {
  background: var(--vd-accent-subtle);
  color: var(--vd-accent);
  border-color: var(--vd-accent);
}

.vd-filter-pill .vd-count {
  font-size: 10px;
  opacity: 0.8;
}

/* Sidebar Route List & Tree View */
.vd-route-list {
  flex: 1;
  overflow-y: auto;
  padding: 6px;
  display: flex;
  flex-direction: column;
}

.vd-tree-container {
  display: flex;
  flex-direction: column;
  gap: 1px;
}

.vd-tree-node {
  display: flex;
  align-items: center;
  height: 26px;
  padding-right: 8px;
  cursor: pointer;
  user-select: none;
  font-size: 12px;
  color: var(--vd-text-primary);
  border-radius: 4px;
  margin: 1px 0;
  transition: background 0.1s ease;
}

.vd-tree-node:hover {
  background-color: var(--vd-surface-hover);
}

.vd-tree-node.selected {
  background-color: var(--vd-surface-active);
  color: var(--vd-accent);
  font-weight: 500;
  box-shadow: inset 2px 0 0 var(--vd-accent);
}

.vd-tree-chevron {
  width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 700;
  color: var(--vd-text-muted);
  cursor: pointer;
  border-radius: 3px;
  flex-shrink: 0;
  transition: transform 0.1s ease, color 0.1s ease;
}

.vd-tree-chevron:hover {
  color: var(--vd-text-primary);
  background-color: var(--vd-surface-active);
}

.vd-status-dot {
  font-size: 10px;
  line-height: 1;
  margin: 0 6px 0 2px;
  flex-shrink: 0;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.vd-status-dot.changed {
  color: #e3b341;
}

.vd-status-dot.added {
  color: #3fb950;
}

.vd-status-dot.removed {
  color: #f85149;
}

.vd-status-dot.unchanged {
  color: var(--vd-text-muted);
  opacity: 0.7;
}

.vd-tree-label {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-family: var(--vd-font);
}

.vd-route-item {
  padding: 9px 12px;
  border-radius: 6px;
  background: transparent;
  border: 1px solid transparent;
  cursor: pointer;
  display: flex;
  flex-direction: column;
  gap: 4px;
  transition: all 0.1s ease;
}

.vd-route-item:hover {
  background-color: var(--vd-surface-hover);
}

.vd-route-item.selected {
  background-color: var(--vd-surface-active);
  border-color: var(--vd-accent);
}

.vd-route-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.vd-route-name {
  font-size: 13px;
  font-weight: 500;
  color: var(--vd-text-primary);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  font-family: var(--vd-font-mono);
}

.vd-route-bottom {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 11px;
  color: var(--vd-text-muted);
}

.vd-badge {
  font-size: 10px;
  font-weight: 600;
  padding: 1px 6px;
  border-radius: 10px;
  text-transform: uppercase;
  letter-spacing: 0.3px;
}

.vd-badge-changed {
  background: var(--vd-badge-changed-bg);
  color: var(--vd-badge-changed-text);
  border: 1px solid var(--vd-badge-changed-border);
}

.vd-badge-added {
  background: var(--vd-badge-added-bg);
  color: var(--vd-badge-added-text);
  border: 1px solid var(--vd-badge-added-border);
}

.vd-badge-removed {
  background: var(--vd-badge-removed-bg);
  color: var(--vd-badge-removed-text);
  border: 1px solid var(--vd-badge-removed-border);
}

.vd-badge-unchanged {
  background: var(--vd-badge-unchanged-bg);
  color: var(--vd-badge-unchanged-text);
  border: 1px solid var(--vd-badge-unchanged-border);
}

.vd-viewport-badge {
  background: var(--vd-bg-tertiary);
  color: var(--vd-text-secondary);
  border: 1px solid var(--vd-border-subtle);
  font-size: 10px;
  padding: 1px 5px;
  border-radius: 4px;
}

/* Main Canvas */
.vd-canvas {
  flex: 1;
  display: flex;
  flex-direction: column;
  background-color: var(--vd-bg);
  overflow: hidden;
}

/* Canvas Toolbar */
.vd-canvas-bar {
  height: 48px;
  background-color: var(--vd-bg-secondary);
  border-bottom: 1px solid var(--vd-border);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 16px;
  flex-shrink: 0;
  gap: 12px;
}

.vd-canvas-info {
  display: flex;
  align-items: center;
  gap: 10px;
}

.vd-canvas-route {
  font-family: var(--vd-font-mono);
  font-size: 13px;
  font-weight: 600;
  color: var(--vd-text-primary);
}

.vd-canvas-dimensions {
  font-family: var(--vd-font-mono);
  font-size: 11px;
  color: var(--vd-text-muted);
  background: var(--vd-bg-tertiary);
  padding: 2px 6px;
  border-radius: 4px;
}

.vd-canvas-metrics {
  font-size: 12px;
  color: var(--vd-text-secondary);
  display: flex;
  align-items: center;
  gap: 6px;
}

.vd-btn-accept {
  background: var(--vd-badge-added-bg);
  color: var(--vd-badge-added-text);
  border: 1px solid var(--vd-badge-added-border);
  padding: 4px 10px;
  border-radius: 6px;
  font-size: 11px;
  font-weight: 600;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 5px;
  margin-left: 8px;
  transition: all 0.15s ease;
}

.vd-btn-accept:hover {
  background: #238636;
  color: #ffffff;
  border-color: #2ea043;
}

/* Viewport Switcher Controls */
.vd-viewport-switcher {
  display: flex;
  gap: 3px;
  background: var(--vd-bg-tertiary);
  padding: 2px;
  border-radius: 6px;
  border: 1px solid var(--vd-border);
}

.vd-vp-btn {
  display: flex;
  align-items: center;
  gap: 5px;
  padding: 3px 8px;
  font-size: 11px;
  font-weight: 600;
  border: none;
  background: transparent;
  color: var(--vd-text-secondary);
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.15s ease;
}

.vd-vp-btn:hover:not(.disabled) {
  color: var(--vd-text-primary);
  background: var(--vd-surface-hover);
}

.vd-vp-btn.active {
  background: var(--vd-surface);
  color: var(--vd-accent);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
}

.vd-vp-btn.disabled {
  opacity: 0.4;
  cursor: not-allowed;
}

.vd-vp-icon {
  font-size: 12px;
}

.vd-vp-diff-pill {
  font-size: 10px;
  font-family: var(--vd-font-mono);
  padding: 1px 4px;
  border-radius: 8px;
  background: var(--vd-badge-changed-bg);
  color: var(--vd-badge-changed-text);
  border: 1px solid var(--vd-badge-changed-border);
}

/* Viewport Containers */
.vd-viewport-container {
  flex: 1;
  overflow: auto;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding: 24px;
  background-image: radial-gradient(var(--vd-border-subtle) 1px, transparent 1px);
  background-size: 20px 20px;
}

/* 2-Up / Side by Side Viewer */
.vd-2up-wrapper {
  display: flex;
  gap: 20px;
  max-width: 100%;
}

.vd-2up-pane {
  display: flex;
  flex-direction: column;
  background: var(--vd-surface);
  border: 1px solid var(--vd-border);
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  overflow: hidden;
}

.vd-pane-header {
  height: 32px;
  background: var(--vd-bg-secondary);
  border-bottom: 1px solid var(--vd-border);
  padding: 0 10px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  color: var(--vd-text-secondary);
}

.vd-pane-img {
  display: block;
  max-width: 100%;
  height: auto;
}

/* Swipe Slider Viewer - Pixel Perfect with clip-path */
.vd-swipe-wrapper {
  position: relative;
  display: inline-block;
  max-width: 100%;
  background: var(--vd-surface);
  border: 1px solid var(--vd-border);
  border-radius: 8px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.25);
  overflow: hidden;
  user-select: none;
  -webkit-user-select: none;
  cursor: ew-resize;
  touch-action: none;
}

.vd-swipe-baseline {
  display: block;
  max-width: 100%;
  height: auto;
  pointer-events: none;
  -webkit-user-drag: none;
  user-select: none;
}

.vd-swipe-current {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: block;
  pointer-events: none;
  -webkit-user-drag: none;
  user-select: none;
}

.vd-swipe-divider {
  position: absolute;
  top: 0;
  bottom: 0;
  width: 2px;
  background: #ffffff;
  box-shadow: 0 0 8px rgba(0, 0, 0, 0.6);
  pointer-events: none;
  z-index: 10;
  transform: translateX(-50%);
}

.vd-swipe-handle {
  position: sticky;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: var(--vd-accent);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 11px;
  font-weight: 700;
  border: 2px solid #ffffff;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
  cursor: ew-resize;
  pointer-events: none;
  user-select: none;
  -webkit-user-select: none;
  touch-action: none;
  z-index: 12;
}

.vd-swipe-range {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0;
  margin: 0;
  padding: 0;
  cursor: ew-resize;
  z-index: 25;
  -webkit-appearance: none;
  appearance: none;
  background: transparent;
  touch-action: none;
}

.vd-swipe-range::-webkit-slider-runnable-track {
  width: 100%;
  height: 100%;
  cursor: ew-resize;
  background: transparent;
}

.vd-swipe-range::-webkit-slider-thumb {
  -webkit-appearance: none;
  width: 48px;
  height: 100%;
  cursor: ew-resize;
  background: transparent;
}

.vd-swipe-range::-moz-range-track {
  width: 100%;
  height: 100%;
  cursor: ew-resize;
  background: transparent;
}

.vd-swipe-range::-moz-range-thumb {
  width: 48px;
  height: 100%;
  cursor: ew-resize;
  background: transparent;
}

.vd-swipe-badge {
  position: absolute;
  top: 10px;
  padding: 3px 8px;
  font-size: 10px;
  font-weight: 600;
  border-radius: 4px;
  background: rgba(0, 0, 0, 0.65);
  color: #ffffff;
  pointer-events: none;
  backdrop-filter: blur(4px);
  z-index: 5;
  letter-spacing: 0.3px;
}

.vd-swipe-badge.before {
  left: 10px;
}

.vd-swipe-badge.after {
  right: 10px;
}

/* Onion Skin Viewer */
.vd-onion-wrapper {
  position: relative;
  background: var(--vd-surface);
  border: 1px solid var(--vd-border);
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  overflow: hidden;
}

.vd-onion-baseline {
  display: block;
  max-width: 100%;
  height: auto;
}

.vd-onion-current {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.vd-onion-bar {
  margin-top: 12px;
  display: flex;
  align-items: center;
  gap: 12px;
  background: var(--vd-surface);
  padding: 8px 16px;
  border-radius: 20px;
  border: 1px solid var(--vd-border);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

/* Diff Mask Viewer */
.vd-diff-wrapper {
  position: relative;
  background: var(--vd-surface);
  border: 1px solid var(--vd-border);
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  overflow: hidden;
}

.vd-diff-img {
  display: block;
  max-width: 100%;
  height: auto;
}

/* Toggle / Flicker Viewer */
.vd-toggle-wrapper {
  position: relative;
  background: var(--vd-surface);
  border: 1px solid var(--vd-border);
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
  overflow: hidden;
}

.vd-toggle-img {
  display: block;
  max-width: 100%;
  height: auto;
}

.vd-toggle-indicator {
  position: absolute;
  top: 12px;
  right: 12px;
  background: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.5px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(4px);
}

/* Modal */
.vd-modal-backdrop {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(2px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.vd-modal {
  background: var(--vd-surface);
  border: 1px solid var(--vd-border);
  border-radius: 10px;
  width: 440px;
  max-width: 90vw;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
  overflow: hidden;
}

.vd-modal-header {
  padding: 14px 18px;
  border-bottom: 1px solid var(--vd-border);
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 14px;
  font-weight: 600;
}

.vd-modal-body {
  padding: 16px 18px;
  display: flex;
  flex-direction: column;
  gap: 10px;
  font-size: 13px;
}

.vd-shortcut-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.vd-kbd {
  font-family: var(--vd-font-mono);
  font-size: 11px;
  background: var(--vd-bg-tertiary);
  border: 1px solid var(--vd-border);
  padding: 2px 6px;
  border-radius: 4px;
  color: var(--vd-text-primary);
}
''';
