// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
import jQuery from "jquery";
window.jquery = window.$ = jQuery;
import "bootstrap";

// gets the iso date format of the given date and time string
function getIsoDate(date, time) {
  let year = date.slice(0, 4);
  let month = date.slice(5, 7);
  let day = date.slice(8, 10);
  let hours = time.slice(0, 2);
  let minutes = time.slice(3, 5);
  let date_object = new Date(year, month, day, hours, minutes);
  return date_object.toISOString();
}

// converts and ISO format string into a more readable format.
function formatIsoString(date) {
  let d = new Date(date);
  return (
    d.getMonth() +
    "/" +
    d.getDate() +
    "/" +
    d.getFullYear() +
    " at " +
    d.getHours() +
    ":" +
    (d.getMinutes() < 10 ? "0" : "") +
    d.getMinutes()
  );
}

// gets the number of minutes between the start and end date
function getDuration(start, end) {
  var date1 = new Date(start);
  var date2 = new Date(end);
  var diff = Math.abs(date2.getTime() - date1.getTime());
  return Math.ceil(diff / 60000);
}

/* gets a given cookie */
function getCookie(input) {
  var cookies = document.cookie.split(";");
  for (var i = 0; i < cookies.length; i++) {
    var name = cookies[i].split("=")[0].toLowerCase();
    var value = cookies[i].split("=")[1].toLowerCase();
    if (name === input) {
      return value;
    }
  }
  return "";
}

$(function() {
  let blockIds = [];
  // render timeblocks in table
  function update_timeblocks(task_id) {
    $.ajax(`${timeblock_path}?task_id=${task_id}`, {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: resp => {
        $("#timeblocks").empty();
        for (var tb in resp.data) {
          let block = resp.data[tb];
          blockIds.push(block.id);
          $("#timeblocks").append(
            "<tr>" +
              "<td>" +
              formatIsoString(block.start_time) +
              "</td>" +
              "<td>" +
              formatIsoString(block.end_time) +
              "</td>" +
              "<td>" +
              getDuration(block.start_time, block.end_time) +
              "</td>" +
              '<td> <button class="btn btn-danger" data-timeblock-id="' +
              block.id +
              '"id="delete-timeblock' +
              block.id +
              '">Delete</button> </td>' +
              "</tr>"
          );
        }

        for (var id in blockIds) {
          // adds a timeblock to database on click
          let idString = "#delete-timeblock" + blockIds[id];
          $(idString).click(ev => {
            let blockid = $(ev.target).data("timeblock-id");
            $.ajax(timeblock_delete_path(blockid), {
              method: "delete",
              dataType: "json",
              contentType: "application/json; charset=UTF-8",
              data: "",
              success: resp => {
                update_timeblocks($("#addTimeblock-button").data("task-id"));
              }
            });
          });
        }
      }
    });
  }

  // call update_timeblocks on DOMReady
  update_timeblocks($("#addTimeblock-button").data("task-id"));

  function addTimeblock(ev, start, end) {
    let task_id = $(ev.target).data("task-id");
    let minutes = getDuration(start, end);
    let data = JSON.stringify({
      timeblock: {
        start_time: start,
        end_time: end,
        minutes: minutes,
        task_id: task_id
      }
    });

    $.ajax(timeblock_path, {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: data,
      success: resp => {
        update_timeblocks(task_id);
      }
    });
  }

  // adds a timeblock to database on click
  $("#addTimeblock-button").click(ev => {
    let start_time = $("#start-time").val();
    let start_date = $("#start-date").val();
    let end_time = $("#end-time").val();
    let end_date = $("#end-date").val();
    let start = getIsoDate(start_date, start_time);
    let end = getIsoDate(end_date, end_time);
    addTimeblock(ev, start, end);
  });

  // starts/stops measuring time real-time on click
  $("#startEndAddTimeblock").click(ev => {
    if (getCookie("measuringtime") == "true") {
      let start = getCookie(" start")
        .replace("z", "Z")
        .replace("t", "T");
      let end = new Date().toISOString();
      addTimeblock(ev, start, end);
      document.cookie =
        "measuringTime=false; expires= Wed, 14 Mar 2029 20:00:00 UTC";
    } else {
      let curTime = new Date().toISOString();
      document.cookie =
        "measuringTime=true; expires= Wed, 14 Mar 2029 20:00:00 UTC";
      document.cookie =
        "start=" + curTime + "; expires= Wed, 14 Mar 2029 20:00:00 UTC";
    }
  });
});
