#!/usr/bin/env gosh

(use file.util)
(use fixedpoint.site)
(use text.html-lite)
(use text.tree)

(//
 (ffmpeg-php "http://ffmpeg-php.sourceforge.net/")
 (rmovie "http://rmovie.rubyforge.org/")
 (FFmpeg::Command "http://search.cpan.org/~mizzy/FFmpeg-Command-0.06/lib/FFmpeg/Command.pm")
 )

(define *last-update* "Tue May 08 2007")
(define *gauche-ffmpeg-version* (file->string "../VERSION"))
(define *gauche-ffmpeg-tarball-basename* (string-append "Gauche-ffmpeg-" *gauche-ffmpeg-version* ".tgz"))
(define *gauche-ffmpeg-tarball-size* (file-size (string-append "../../" *gauche-ffmpeg-tarball-basename*)))
(define *gauche-ffmpeg-tarball-url* *gauche-ffmpeg-tarball-basename*)

(define (index lang)
  (let-syntax ((en/ja (syntax-rules ()
						((_ en ja)
						 (if (string=? "en" lang) en ja)))))
	((fixedpoint:frame "Gauche-ffmpeg")
	 (html:p :id "lang_navi" (html:a :href (en/ja "index.html" "index.en.html")
										"[" (en/ja "Japanese" "English") "]"))
	 (html:p :id "last_update" "Last update: " *last-update*)
	 (fixedpoint:separator)
	 (fixedpoint:adsense)
	 (fixedpoint:separator)
	 (html:p (html:dfn /Gauche-ffmpeg/)
			 (en/ja
				 (list " is an extension package of " /Gauche/ " which provides a binding of " /ffmpeg/ ".")
				 (list " は " /Scheme/ " 処理系 " /Gauche/ " で " /ffmpeg/ " を利用するための拡張パッケージです。")))
	 (en/ja '()
			(html:p "ffmpeg 一般についての日本語の情報は" (html:a :href "/ffmpeg/" "別ページ") "にまとめています。"))

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "News" "最新情報"))
	 (html:ul
	  (html:li "[2007-05-08] " (en/ja "Release 0.1.1, which now runs on Gauche 0.8.10."
									  "バージョン 0.1.1 を公開しました。Gauche 0.8.10 で動作します。"))
	  (html:li "[2007-01-18] " (en/ja "It is confirmed that the current version 0.1.0 runs on Gauche 0.8.9."
									  "Gauche 0.8.9 で現在のバージョン 0.1.0 が動作することを確認しました。"))
	  (html:li "[2006-12-07] " (en/ja "Release 0.1.0." "バージョン 0.1.0 を公開しました。")))

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Features" "特徴"))
	 (html:ul
	  (html:li (en/ja "some descriptions on media files."
					  "メディアファイルの情報の取得。"))
	  (html:li (en/ja "accessors of libavcodec/libavformat version info."
					  "libavcodec/libavformat のバージョン情報へのアクセス。"))
	  )

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Requirements" "導入"))
	 (html:p (en/ja "This package is for Gauche 0.8.7 or later."
					"このパッケージは Gauche 0.8.7 またはそれ以上で動作します。"))
	 (html:ul
	  (html:li (en/ja (list "It requires the current SVN release of " /ffmpeg/ " which has been installed with a shared library option.")
					  (list "また別途、現在の SVN リリース版 " /ffmpeg/ " の共有ライブラリがインストールされている必要があります。"))))

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Download" "ダウンロード"))
	 (html:p (html:a :href *gauche-ffmpeg-tarball-url*
					 *gauche-ffmpeg-tarball-basename* " (" *gauche-ffmpeg-tarball-size*  " bytes)"))

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Documents" "文書"))
	 (html:ul
	  (html:li (html:a :href (en/ja "reference.en.html" "reference.ja.html")
					   "Gauche-ffmpeg " (en/ja "Reference Manual" "リファレンスマニュアル"))))

	 (html:h2 :style "border-bottom: 1px solid #bbbbbb;" (en/ja "Links" "リンク"))
	 (html:ul
	  (html:li /ffmpeg/)
	  (html:li /ffmpeg-php/)
	  (html:li /rmovie/)
	  (html:li /FFmpeg::Command/)
	  )
	 )))

(define (main args)
  (define (usage)
	(format (current-error-port) "usage: gosh ~a (en|ja)\n" *program-name*)
	(exit 1))
  (when (< (length args) 2)
	(usage))
  (write-tree (index (cadr args)))
  0)
