// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
  //layouts/application.html.erb-------------------------
  $("#jumpbox").submit(doTicketJump);

  //tickets/index.html.erb-------------------------------
  $("#ticket-filter").hide();

  //tickets/show.html.erb--------------------------------
  $("#add-comment").hide();
  $("#add-attachment").hide();
  $("#attachments-toggle").click(function() {
    $("#attachment-list").slideToggle();
  });
  $("#comments-toggle").click(function() {
    $("#comment-list").slideToggle();
  });

  //dashboard/index.html.erb-----------------------------
  $("#timeline-toggle").click(function() {
    $("#timeline-wrapper").slideToggle();
  });
  $("#active-tickets").click(function() {
    $("#active-listing").slideToggle();
  });
  $("#closed-tickets").click(function() {
    $("#closed-listing").slideToggle();
  });

  //users/show.html.erb----------------------------------
  $("#alerts-toggle").click(function() {
    $("#alert-list").slideToggle();
  });
  $("#assigned-to-toggle").click(function() {
    $("#assigned-to-listing").slideToggle();
  });

  //admin/index.html.erb---------------------------------
  $("#group-enabled-toggle").click(function() {
    $("#group-enabled-list").slideToggle();
  });
  $("#group-disabled-toggle").click(function() {
    $("#group-disabled-list").slideToggle();
  });
  $("#status-enabled-toggle").click(function() {
    $("#status-enabled-list").slideToggle();
  });
  $("#status-disabled-toggle").click(function() {
    $("#status-disabled-list").slideToggle();
  });
  $("#priority-enabled-toggle").click(function() {
    $("#priority-enabled-list").slideToggle();
  });
  $("#priority-disabled-toggle").click(function() {
    $("#priority-disabled-list").slideToggle();
  });

  // site-wide submit buttons...disable on form submit
  $('form').submit(function(){
    $('input[type=submit]', this).attr('disabled', 'disabled');
  });

  // site-wide toggle headers
  $(".toggle").toggle(function() {
    $(this).addClass("closed");
    }, function () {
    $(this).removeClass("closed");
  });
    
  // site-wide flash message animation
  hideFlash();
});

//ticket jump form
function doTicketJump() {
    var ticket_id = document.getElementById("jump_id").value;
    var app_root = document.getElementById("app_root").value;
    if ((ticket_id != "") && (ticket_id.length > 0)) {
        location.href = app_root+"/tickets/"+ticket_id;
    }
    return false;
}

//hide flash messages with jQuery fadeOut
function hideFlash() {
  var flash_div = $(".flash");
  setTimeout(function() { flash_div.fadeOut(2500, function() { flash_div.html(""); flash_div.hide(); })}, 3500);
}

//get today's date
function getToday() {
    var d = new Date();
    return d.getFullYear().toString() + "-" + (d.getMonth()+1).toString() + "-" + d.getDate().toString()
}
