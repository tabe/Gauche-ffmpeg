#!/usr/bin/env gosh
;; -*- mode: scheme; coding: euc-jp -*-

(use fixedpoint.package)
(use fixedpoint.site)
(use text.html-lite)

(//
 (ffmpeg-php "http://ffmpeg-php.sourceforge.net/")
 (rmovie "http://rmovie.rubyforge.org/")
 (FFmpeg::Command "http://search.cpan.org/~mizzy/FFmpeg-Command-0.07/lib/FFmpeg/Command.pm")
 )

(define-package Gauche-ffmpeg 2008 1 23)

(define-index Gauche-ffmpeg
  (html:p (html:dfn /Gauche-ffmpeg/)
          (en/ja
           (list " is an extension package of " /Gauche/ " which provides a binding of " /ffmpeg/ ".")
           (list " は " /Scheme/ " 処理系 " /Gauche/ " で " /ffmpeg/ " を利用するための拡張パッケージです。")))
  (en/ja '()
         (html:p "ffmpeg 一般についての日本語の情報は" (html:a :href "/ffmpeg/" "別ページ") "にまとめています。"))

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "News" "最新情報"))
  (html:ul
   (html:li "[2008-01-23] " (en/ja "Release 0.2.0. Introduced liavdevice."
                                   "バージョン 0.2.0 を公開しました。libavdevice を導入しました。"))
   (html:li "[2007-11-01] " (en/ja "It is confirmed that the current version 0.1.1 runs on Gauche 0.8.12."
                                  "Gauche 0.8.12 で現在のバージョン 0.1.1 が動作することを確認しました。"))
   (html:li "[2007-05-08] " (en/ja "Release 0.1.1, which now runs on Gauche 0.8.10."
                                   "バージョン 0.1.1 を公開しました。Gauche 0.8.10 で動作します。"))
   (html:li "[2007-01-18] " (en/ja "It is confirmed that the current version 0.1.0 runs on Gauche 0.8.9."
                                   "Gauche 0.8.9 で現在のバージョン 0.1.0 が動作することを確認しました。"))
   (html:li "[2006-12-07] " (en/ja "Release 0.1.0." "バージョン 0.1.0 を公開しました。")))

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Features" "特徴"))
  (html:ul
   (html:li (en/ja "some descriptions on media files."
                   "メディアファイルの情報の取得。"))
   (html:li (en/ja "accessors of libavcodec/libavformat/libavdevice version info."
                   "libavcodec/libavformat/libavdevice のバージョン情報へのアクセス。"))
   )

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Requirements" "導入"))
  (html:p (en/ja "This package is for Gauche 0.8.12 or later."
                 "このパッケージは Gauche 0.8.12 またはそれ以上で動作します。"))
  (html:ul
   (html:li (en/ja (list "It requires the current SVN release of " /ffmpeg/ " which has been installed as a shared library.")
                   (list "また別途、現在の SVN リリース版 " /ffmpeg/ " の共有ライブラリがインストールされている必要があります。"))))

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "License" "ライセンス"))
  (html:p "GNU Lesser General Public License, Version 2.1")

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Download" "ダウンロード"))
  (*package-download*)

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Documentation" "文書"))
  (html:ul
   (html:li (html:a :href (en/ja "reference.en.html" "reference.ja.html")
                    "Gauche-ffmpeg " (en/ja "Reference Manual" "リファレンスマニュアル"))))

  (html:h2 :stle "border-bottom: 1px solid #bbbbbb;" (en/ja "Known Issues" "既知の問題"))
  (html:ul
   (html:li (en/ja "Loading the modules are not thread safe."
                   "モジュールの読み込みはスレッドセーフではありません。"))
   )

  (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Links" "リンク"))
  (html:ul
   (html:li /ffmpeg/)
   (html:li /ffmpeg-php/)
   (html:li /rmovie/)
   (html:li /FFmpeg::Command/)
   )
  )

(define main package-main)
