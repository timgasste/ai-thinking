#!/usr/bin/env python3
"""Check that every prompt shown on the slides also appears, word for word, on the page.

Usage: scripts/check-sync.py ../puma-ai-presentations/presentation.qmd index.qmd
"""
import html, re, sys

deck, page = (open(p, encoding="utf-8").read() for p in sys.argv[1:3])
norm = lambda t: " ".join(html.unescape(re.sub(r"<[^>]+>", "", t)).split())
prompts = [norm(m) for m in re.findall(r'<div class="mini-chat-text">(.*?)</div>', deck, re.S)]
anatomy = re.search(r'<p><span class="anat-seg anat-seg--1">.*?</p>', deck, re.S)
if anatomy:
    prompts.append(norm(anatomy.group(0)))
page_text = norm(page)
missing = [p for p in prompts if p not in page_text]
for p in missing:
    print("MISSING on page:", p[:110], "...")
print(f"{len(prompts) - len(missing)}/{len(prompts)} slide prompts found on the page")
sys.exit(1 if missing else 0)
