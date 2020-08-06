// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_raty
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .


$(function() {
	$(document).on('turbolinks:load', () => {

		// 画像プレビュー
		// inputのidから情報の取得
	    $('#image').on('change', function (e) {
		// ここから既存の画像のurlの取得
	    var reader = new FileReader();
	    reader.onload = function (e) {
	        $(".image").attr('src', e.target.result);
	    }
	    reader.readAsDataURL(e.target.files[0]); //取得したurlにアップロード画像のurlを挿入
		});

		// 星評価
		$('#star').raty({
		size: 36,
	    starOff: '/assets/star-off.png',
	    starOn: '/assets/star-on.png',
	    starHalf: '/assets/star-half.png',
	    scoreName: 'post_comment[rate]', //reviewカラムに保存
	    half: true, //★の半分の入力を行う
		});

	});
});

//エリア・都道府県クリックで表示
document.addEventListener("turbolinks:load", function() {
	$(function(){
		$(".openBtn").click(function(){
		  $(this).next(".textArea").animate({
		  	height: 'toggle', opacity: 'toggle'  //折りたたみ
		  },'nomal');  //速度
		});
	});


	// マウスオンで検索サイドバーを表示
	$(function() {
	    $('#slide').hover(
	    	function(){
	    		$(this).stop(true).animate({'marginRight':'300px'},500);
	    	},
	    	function () {
	    		$(this).animate({'marginRight':'0'},500);
	    	}
	    );
	});

	// スライドさせる
	$(document).ready(function(){
		fit();
		$(window).resize(function(){
			fit();
		})
		function fit(){
			var h = $(window).height();
			$('.slide-inner').css("height",h);
		}
	});
})
