// Copyright 2026 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Shadow DOM stylesheet for the visual review overlay.
///
/// Scoped completely inside `#dash-review-host`'s shadow root so styles from
/// `docs.flutter.dev` and `flutter.dev` never leak in, and review UI styles
/// never leak out into site content.
const String reviewOverlayStyles = '''
:host {
  all: initial;
  position: fixed;
  inset: 0;
  z-index: 2147483640;
  pointer-events: none;
  font-family: 'Google Sans Flex', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  line-height: 1.45;
  -webkit-font-smoothing: antialiased;
}

*, *::before, *::after {
  box-sizing: border-box;
}

.dr-root {
  --dr-bg: rgba(255, 255, 255, 0.96);
  --dr-bg-elevated: #ffffff;
  --dr-bg-subtle: #f3f5f8;
  --dr-bg-hover: #eaeef4;
  --dr-fg: #0f172a;
  --dr-fg-muted: #475569;
  --dr-fg-subtle: #64748b;
  --dr-border: rgba(15, 23, 42, 0.12);
  --dr-border-strong: rgba(15, 23, 42, 0.22);
  --dr-accent: #2563eb;
  --dr-accent-hover: #1d4ed8;
  --dr-accent-soft: rgba(37, 99, 235, 0.11);
  --dr-local-fg: #047857;
  --dr-local-bg: rgba(16, 185, 129, 0.14);
  --dr-preview-fg: #0369a1;
  --dr-preview-bg: rgba(14, 165, 233, 0.15);
  --dr-warn-fg: #b45309;
  --dr-warn-bg: rgba(245, 158, 11, 0.15);
  --dr-danger: #dc2626;
  --dr-danger-soft: rgba(220, 38, 38, 0.11);
  --dr-resolved: #059669;
  --dr-shadow-lg: 0 16px 40px rgba(15, 23, 42, 0.18), 0 2px 8px rgba(15, 23, 42, 0.08);
  --dr-shadow-md: 0 8px 24px rgba(15, 23, 42, 0.15), 0 1px 4px rgba(15, 23, 42, 0.08);
  --dr-code-font: 'Google Sans Code', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;

  position: fixed;
  inset: 0;
  pointer-events: none;
  color: var(--dr-fg);
  font-size: 13px;
}

.dr-root[data-theme="dark"] {
  --dr-bg: rgba(17, 24, 39, 0.95);
  --dr-bg-elevated: #1e293b;
  --dr-bg-subtle: #0f172a;
  --dr-bg-hover: #334155;
  --dr-fg: #f8fafc;
  --dr-fg-muted: #cbd5e1;
  --dr-fg-subtle: #94a3b8;
  --dr-border: rgba(248, 250, 252, 0.14);
  --dr-border-strong: rgba(248, 250, 252, 0.26);
  --dr-accent: #3b82f6;
  --dr-accent-hover: #2563eb;
  --dr-accent-soft: rgba(59, 130, 246, 0.18);
  --dr-local-fg: #34d399;
  --dr-local-bg: rgba(16, 185, 129, 0.18);
  --dr-preview-fg: #38bdf8;
  --dr-preview-bg: rgba(56, 189, 248, 0.18);
  --dr-warn-fg: #fbbf24;
  --dr-warn-bg: rgba(245, 158, 11, 0.18);
  --dr-danger: #f87171;
  --dr-danger-soft: rgba(248, 113, 113, 0.16);
  --dr-resolved: #10b981;
  --dr-shadow-lg: 0 18px 44px rgba(0, 0, 0, 0.52), 0 2px 10px rgba(0, 0, 0, 0.35);
  --dr-shadow-md: 0 10px 28px rgba(0, 0, 0, 0.45), 0 1px 6px rgba(0, 0, 0, 0.3);
}

.dr-hidden {
  display: none !important;
}

.dr-layer {
  position: fixed;
  inset: 0;
  pointer-events: none;
  overflow: hidden;
}

/* Hover inspector & drag rubberband */
.dr-hover-box {
  position: fixed;
  pointer-events: none;
  border: 2px solid var(--dr-accent);
  background: rgba(37, 99, 235, 0.07);
  border-radius: 6px;
  transition: top 0.04s linear, left 0.04s linear, width 0.04s linear, height 0.04s linear;
  z-index: 5;
}

.dr-hover-label {
  position: absolute;
  top: -24px;
  left: -2px;
  background: var(--dr-accent);
  color: #ffffff;
  font-family: var(--dr-code-font);
  font-size: 11px;
  font-weight: 600;
  padding: 2px 7px;
  border-radius: 5px;
  white-space: nowrap;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
}

.dr-drag-box {
  position: fixed;
  pointer-events: none;
  border: 2px dashed var(--dr-accent);
  background: rgba(37, 99, 235, 0.14);
  border-radius: 6px;
  z-index: 6;
}

/* Anchored page highlights & pins */
.dr-highlight-text {
  position: fixed;
  pointer-events: none;
  background: rgba(245, 158, 11, 0.24);
  border-bottom: 2px solid rgba(217, 119, 6, 0.8);
  border-radius: 3px;
  z-index: 3;
}

.dr-highlight-text[data-active="true"] {
  background: rgba(37, 99, 235, 0.24);
  border-bottom-color: var(--dr-accent);
  box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.22);
}

.dr-highlight-text[data-resolved="true"] {
  background: rgba(16, 185, 129, 0.14);
  border-bottom-color: rgba(16, 185, 129, 0.55);
}

.dr-highlight-box {
  position: fixed;
  pointer-events: none;
  border: 2px dashed rgba(37, 99, 235, 0.65);
  background: rgba(37, 99, 235, 0.06);
  border-radius: 6px;
  z-index: 3;
}

.dr-highlight-box[data-active="true"] {
  border-style: solid;
  border-color: var(--dr-accent);
  background: rgba(37, 99, 235, 0.11);
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.18);
}

.dr-highlight-box[data-resolved="true"] {
  border-color: rgba(16, 185, 129, 0.55);
  background: rgba(16, 185, 129, 0.05);
}

.dr-pin {
  position: fixed;
  pointer-events: auto;
  width: 24px;
  height: 24px;
  border-radius: 999px 999px 999px 4px;
  background: var(--dr-accent);
  color: #ffffff;
  border: 2px solid #ffffff;
  font-size: 11px;
  font-weight: 700;
  font-family: inherit;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.28);
  transform: translate(-50%, -85%);
  transition: transform 0.12s ease, background-color 0.12s ease, box-shadow 0.12s ease;
  z-index: 12;
  padding: 0;
}

.dr-pin:hover,
.dr-pin[data-active="true"] {
  transform: translate(-50%, -85%) scale(1.14);
  box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.28), 0 4px 12px rgba(0, 0, 0, 0.32);
  z-index: 15;
}

.dr-pin[data-resolved="true"] {
  background: var(--dr-resolved);
  opacity: 0.88;
}

/* Text selection floating pill */
.dr-selection-pill {
  position: fixed;
  pointer-events: auto;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 12px;
  border-radius: 999px;
  background: #0f172a;
  color: #f8fafc;
  border: 1px solid rgba(255, 255, 255, 0.16);
  box-shadow: var(--dr-shadow-md);
  font-size: 12px;
  font-weight: 600;
  font-family: inherit;
  cursor: pointer;
  transform: translateX(-50%);
  z-index: 25;
  white-space: nowrap;
}

.dr-selection-pill:hover {
  background: var(--dr-accent);
  border-color: var(--dr-accent);
}

/* Comment mode top hint banner */
.dr-mode-banner {
  position: fixed;
  top: 14px;
  left: 50%;
  transform: translateX(-50%);
  pointer-events: auto;
  display: inline-flex;
  align-items: center;
  gap: 10px;
  padding: 7px 14px;
  border-radius: 999px;
  background: #0f172a;
  color: #f8fafc;
  border: 1px solid rgba(59, 130, 246, 0.5);
  box-shadow: var(--dr-shadow-md);
  font-size: 12px;
  font-weight: 500;
  z-index: 28;
}

.dr-kbd {
  display: inline-block;
  padding: 1px 6px;
  border-radius: 4px;
  background: rgba(255, 255, 255, 0.14);
  font-family: var(--dr-code-font);
  font-size: 11px;
}

/* Bottom-right pill toolbar */
.dr-toolbar {
  position: fixed;
  right: 20px;
  bottom: 20px;
  pointer-events: auto;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 8px;
  border-radius: 999px;
  background: var(--dr-bg);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
  border: 1px solid var(--dr-border-strong);
  box-shadow: var(--dr-shadow-lg);
  z-index: 30;
  max-width: calc(100vw - 24px);
}

.dr-mode-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 4px 10px;
  border-radius: 999px;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: 0.03em;
  white-space: nowrap;
}

.dr-mode-badge[data-mode="local"] {
  background: var(--dr-local-bg);
  color: var(--dr-local-fg);
}

.dr-mode-badge[data-mode="preview"] {
  background: var(--dr-preview-bg);
  color: var(--dr-preview-fg);
}

.dr-status-dot {
  width: 7px;
  height: 7px;
  border-radius: 999px;
  background: currentColor;
}

.dr-status-dot[data-offline="true"] {
  background: #f59e0b;
}

.dr-divider {
  width: 1px;
  height: 18px;
  background: var(--dr-border);
  margin: 0 2px;
}

.dr-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  padding: 6px 11px;
  border-radius: 999px;
  border: 1px solid transparent;
  background: transparent;
  color: var(--dr-fg);
  font-family: inherit;
  font-size: 12px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.12s ease, color 0.12s ease, border-color 0.12s ease;
  white-space: nowrap;
}

.dr-btn:hover {
  background: var(--dr-bg-hover);
}

.dr-btn[aria-pressed="true"],
.dr-btn-primary {
  background: var(--dr-accent);
  color: #ffffff;
}

.dr-btn[aria-pressed="true"]:hover,
.dr-btn-primary:hover {
  background: var(--dr-accent-hover);
}

.dr-btn-primary:disabled {
  opacity: 0.55;
  cursor: not-allowed;
}

.dr-btn-secondary {
  background: var(--dr-bg-subtle);
  border-color: var(--dr-border);
  color: var(--dr-fg);
}

.dr-btn-secondary:hover {
  background: var(--dr-bg-hover);
}

.dr-btn-danger {
  color: var(--dr-danger);
}

.dr-btn-danger:hover {
  background: var(--dr-danger-soft);
}

.dr-btn-icon {
  padding: 6px;
  width: 30px;
  height: 30px;
}

.dr-count-pill {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 18px;
  height: 18px;
  padding: 0 5px;
  border-radius: 999px;
  background: var(--dr-accent-soft);
  color: var(--dr-accent);
  font-size: 11px;
  font-weight: 700;
}

/* Composer & Pin Thread Popover */
.dr-popover {
  position: fixed;
  pointer-events: auto;
  width: 370px;
  max-width: calc(100vw - 24px);
  background: var(--dr-bg-elevated);
  border: 1px solid var(--dr-border-strong);
  border-radius: 14px;
  box-shadow: var(--dr-shadow-lg);
  padding: 14px;
  z-index: 35;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.dr-popover-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.dr-chip-row {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 6px;
  min-width: 0;
}

.dr-chip {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 2px 8px;
  border-radius: 6px;
  background: var(--dr-bg-subtle);
  border: 1px solid var(--dr-border);
  color: var(--dr-fg-muted);
  font-family: var(--dr-code-font);
  font-size: 11px;
  max-width: 260px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.dr-chip-status[data-status="resolved"] {
  background: var(--dr-local-bg);
  color: var(--dr-local-fg);
  border-color: transparent;
  font-family: inherit;
  font-weight: 600;
}

.dr-chip-status[data-status="open"] {
  background: var(--dr-accent-soft);
  color: var(--dr-accent);
  border-color: transparent;
  font-family: inherit;
  font-weight: 600;
}

.dr-quote {
  margin: 0;
  padding: 7px 10px;
  border-left: 3px solid var(--dr-accent);
  background: var(--dr-bg-subtle);
  border-radius: 0 8px 8px 0;
  color: var(--dr-fg-muted);
  font-size: 12px;
  max-height: 76px;
  overflow-y: auto;
  word-break: break-word;
}

.dr-textarea,
.dr-input {
  width: 100%;
  border-radius: 9px;
  border: 1px solid var(--dr-border-strong);
  background: var(--dr-bg-subtle);
  color: var(--dr-fg);
  font-family: inherit;
  font-size: 13px;
  padding: 9px 11px;
  outline: none;
}

.dr-textarea {
  min-height: 78px;
  resize: vertical;
}

.dr-textarea:focus,
.dr-input:focus {
  border-color: var(--dr-accent);
  box-shadow: 0 0 0 3px var(--dr-accent-soft);
  background: var(--dr-bg-elevated);
}

.dr-notice {
  padding: 7px 10px;
  border-radius: 8px;
  background: var(--dr-warn-bg);
  color: var(--dr-warn-fg);
  font-size: 11.5px;
}

.dr-popover-actions {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 6px;
}

.dr-action-group {
  display: inline-flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 6px;
}

.dr-comment-body {
  font-size: 13px;
  color: var(--dr-fg);
  white-space: pre-wrap;
  word-break: break-word;
}

.dr-meta-line {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
  font-size: 11px;
  color: var(--dr-fg-subtle);
}

.dr-link {
  color: var(--dr-accent);
  text-decoration: none;
  font-weight: 600;
}

.dr-link:hover {
  text-decoration: underline;
}

/* Slide-over Comments Drawer */
.dr-drawer {
  position: fixed;
  top: 14px;
  right: 16px;
  bottom: 74px;
  width: 400px;
  max-width: calc(100vw - 24px);
  pointer-events: auto;
  background: var(--dr-bg-elevated);
  border: 1px solid var(--dr-border-strong);
  border-radius: 16px;
  box-shadow: var(--dr-shadow-lg);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  z-index: 32;
}

.dr-drawer-header {
  padding: 14px 16px 10px;
  border-bottom: 1px solid var(--dr-border);
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.dr-drawer-title-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.dr-drawer-title {
  margin: 0;
  font-size: 15px;
  font-weight: 700;
}

.dr-filter-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 6px;
  flex-wrap: wrap;
}

.dr-segmented {
  display: inline-flex;
  background: var(--dr-bg-subtle);
  padding: 2px;
  border-radius: 8px;
  border: 1px solid var(--dr-border);
}

.dr-seg-btn {
  border: none;
  background: transparent;
  color: var(--dr-fg-muted);
  font-family: inherit;
  font-size: 11.5px;
  font-weight: 600;
  padding: 4px 9px;
  border-radius: 6px;
  cursor: pointer;
}

.dr-seg-btn[aria-selected="true"] {
  background: var(--dr-bg-elevated);
  color: var(--dr-fg);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.dr-drawer-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.dr-drawer-list {
  flex: 1;
  overflow-y: auto;
  padding: 12px 14px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.dr-empty {
  padding: 32px 16px;
  text-align: center;
  color: var(--dr-fg-subtle);
  font-size: 13px;
}

.dr-card {
  border: 1px solid var(--dr-border);
  background: var(--dr-bg-subtle);
  border-radius: 12px;
  padding: 11px 12px;
  display: flex;
  flex-direction: column;
  gap: 7px;
  cursor: pointer;
  transition: border-color 0.12s ease, background-color 0.12s ease;
}

.dr-card:hover {
  border-color: var(--dr-accent);
  background: var(--dr-bg-elevated);
}

.dr-card-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.dr-pin-mini {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 20px;
  height: 20px;
  padding: 0 5px;
  border-radius: 999px;
  background: var(--dr-accent);
  color: #ffffff;
  font-size: 11px;
  font-weight: 700;
}

.dr-pin-mini[data-resolved="true"] {
  background: var(--dr-resolved);
}

/* Settings Modal */
.dr-modal-backdrop {
  position: fixed;
  inset: 0;
  pointer-events: auto;
  background: rgba(15, 23, 42, 0.45);
  backdrop-filter: blur(3px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 16px;
  z-index: 40;
}

.dr-modal {
  width: 460px;
  max-width: 100%;
  background: var(--dr-bg-elevated);
  border: 1px solid var(--dr-border-strong);
  border-radius: 16px;
  box-shadow: var(--dr-shadow-lg);
  padding: 18px 20px;
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.dr-field {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.dr-label {
  font-size: 12px;
  font-weight: 600;
  color: var(--dr-fg);
}

.dr-help {
  font-size: 11.5px;
  color: var(--dr-fg-subtle);
}

.dr-status-box {
  padding: 9px 12px;
  border-radius: 10px;
  background: var(--dr-bg-subtle);
  border: 1px solid var(--dr-border);
  font-size: 12px;
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.dr-status-box[data-ok="true"] {
  border-color: rgba(16, 185, 129, 0.45);
  background: var(--dr-local-bg);
  color: var(--dr-local-fg);
}

.dr-status-box[data-error="true"] {
  border-color: rgba(220, 38, 38, 0.45);
  background: var(--dr-danger-soft);
  color: var(--dr-danger);
}

/* Toast notifications */
.dr-toast-stack {
  position: fixed;
  right: 20px;
  bottom: 72px;
  pointer-events: none;
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 8px;
  z-index: 45;
}

.dr-toast {
  pointer-events: auto;
  padding: 8px 14px;
  border-radius: 10px;
  background: #0f172a;
  color: #f8fafc;
  border: 1px solid rgba(255, 255, 255, 0.14);
  box-shadow: var(--dr-shadow-md);
  font-size: 12px;
  font-weight: 500;
  max-width: 360px;
}
''';
