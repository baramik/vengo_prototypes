$ ->
  $('#new_video').fileupload
    dataType: 'script'
    add: (e, data) ->
      data.context = $(tmpl("template-upload", data.files[0]))
      $('#new_video').append(data.context)
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10);
        data.context.find('.bar').css('width', progress + '%')
        
  
@checkTransodeJob = (job_id) ->
  timerId = setInterval (->
    $.ajax '/transcoder/job?job_id=' + job_id,
      type: 'GET'
      dataType: 'json'
      error: (data) ->
          $('#transcoder-status').text data.status
          clearInterval(timerId)
      success: (data) ->
          $('#transcoder-status').text data.status
          if data.status == "Complete"
            clearInterval(timerId)
            $('video').last().get(0).load()
  ), 5000
