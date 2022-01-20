var superJumpToggle             = false
var fastRunToggle               = false
var thermalVisionToggle         = false
var nightVisionToggle           = false
var crossHairToggle             = false
var noClipToggle                = false
var rainbowVehicleToggle        = false
var aimbotToggle                = false
var aimbotOnlyPlayersToggle     = true
var aimbotIgnoreVehiclesToggle  = false

var godmodeToggle = false
var enablecontrolsToggle = false

var clientID = "unknown"
var dumppath = "unknown"
var serverIP = "unknown"
var resourceName = "unknown"
var safemodeOPTION = true

// Connect to XUI backend
const socket = new WebSocket('ws://localhost:3724');

// Connection ready
socket.addEventListener('open', function (event) {
  socket.send(JSON.stringify({
    xuinaFrontendActive: true
  }))
});

Swal.fire(
  'Succesfully Injected<br>GTX Menu Loaded',
  'Contact <a href="https://dsc.gg/GTX">GTX Discord</a> for support<br>Made by <a href="https://github.com/Sahbes">Sahbes</a> and <a href="https://github.com/PanchitoVDV">Panchito</a>',
  'info'
)

// Swal.fire({
//   position: 'top-start',
//   title: 'Succesfully injected',
//   html:
//   'GTX Menu made by Sahbes and Panchito<br>' +
//   '<a href="https://dsc.gg/GTX">Join our discord</a><br>' +
//   'have fun!',
//   showConfirmButton: false,
//   timer: 3500
// })

// Listen for messages
var displayed = true
socket.addEventListener('message', function (event) {
    if(JSON.parse(event.data)) {
      var message = JSON.parse(event.data)
      if (message.dumppath != null) {
        dumppath = message.dumppath
        document.getElementById("dumppath").innerHTML = dumppath
      }
      if (message.fivexid != null) {
        clientID = message.fivexid
        document.getElementById("clientid").innerHTML = clientID
      }
      if (message.fivexip != null) {
        serverIP = message.fivexip
        document.getElementById("serverip").innerHTML = serverIP
      }
      if (message.fivexresource != null) {
        resourceName = message.fivexresource
        document.getElementById("resourcename").innerHTML = resourceName
      }
      if (message.display != null) {
        displayed = !displayed
        if (displayed) {
          document.getElementById("main-container").style.display = "block"
        } else {
          document.getElementById("main-container").style.display = "none"
        }
      }
    }
});

/*
  ON - OFF MENU
*/
function superJump() {
  if (!safemodeOPTION) {
    superJumpToggle = !superJumpToggle
    socket.send(JSON.stringify({
      superJump: superJumpToggle
    }))
    if (superJumpToggle) {
      document.getElementById("superJumpToggle").innerHTML = '<div class="enabled">true</div>'
    } else {
      document.getElementById("superJumpToggle").innerHTML = '<div class="disabled">false</div>'
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function fastRun() {
  if (!safemodeOPTION) {
    fastRunToggle = !fastRunToggle
    socket.send(JSON.stringify({
      fastRun: fastRunToggle
    }))
    if (fastRunToggle) {
      document.getElementById("fastRunToggle").innerHTML = '<div class="enabled">true</div>'
    } else {
      document.getElementById("fastRunToggle").innerHTML = '<div class="disabled">false</div>'
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function godmode() {
  if (!safemodeOPTION) {
    godmodeToggle = !godmodeToggle
    socket.send(JSON.stringify({
      godmode: godmodeToggle
    }))
    if (godmodeToggle) {
      document.getElementById("godmodeToggle").innerHTML = '<div class="enabled">true</div>'
    } else {
      document.getElementById("godmodeToggle").innerHTML = '<div class="disabled">false</div>'
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function enablecontrols() {
  enablecontrolsToggle = !enablecontrolsToggle
  socket.send(JSON.stringify({
    enablecontrols: enablecontrolsToggle
  }))
  if (enablecontrolsToggle) {
    document.getElementById("enablecontrolsToggle").innerHTML = '<div class="enabled">true</div>'
  } else {
    document.getElementById("enablecontrolsToggle").innerHTML = '<div class="disabled">false</div>'
  }
}
function respawn() {
  socket.send(JSON.stringify({
    respawn: true
  }))
}
function refill() {
  socket.send(JSON.stringify({
    refill: true
  }))
}
function ESXrevive() {
  socket.send(JSON.stringify({
    ESXrevive: true
  }))
}
function ESXreviveRisk() {
  if (!safemodeOPTION) {
    socket.send(JSON.stringify({
      ESXreviveRisk: true
    }))
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
async function ESXmessage() {
  const { value: Message } = await Swal.fire({
    input: 'text',
    inputPlaceholder: 'Message: ',
    confirmButtonText: 'Send'
  })

  if (Message) {
    socket.send(JSON.stringify({
      ESXmessage: Message
    }))
  }
}
async function ESXroulette() {
  const { value: Amount } = await Swal.fire({
    input: 'text',
    inputPlaceholder: 'Amount: ',
    confirmButtonText: 'Execute'
  })

  if (Amount) {
    socket.send(JSON.stringify({
      ESXroulette: Amount
    }))
  }
}
function vangelicoheist() {
  socket.send(JSON.stringify({
    vangelicoheist: true
  }))
}
function communityservice() {
  socket.send(JSON.stringify({
    communityservice: true
  }))
}
function jailall() {
  socket.send(JSON.stringify({
    jailall: true
  }))
}
function heal() {
  socket.send(JSON.stringify({
    heal: true
  }))
}
function armor() {
  socket.send(JSON.stringify({
    armor: true
  }))
}
function thermalVision() {
  if (!safemodeOPTION) {
    thermalVisionToggle = !thermalVisionToggle
    socket.send(JSON.stringify({
      thermalVision: thermalVisionToggle
    }))
    if (thermalVisionToggle) {
      document.getElementById("thermalVisionToggle").innerHTML = '<div class="enabled">true</div>'
    } else {
      document.getElementById("thermalVisionToggle").innerHTML = '<div class="disabled">false</div>'
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function nightVision() {
  if (!safemodeOPTION) {
    nightVisionToggle = !nightVisionToggle
    socket.send(JSON.stringify({
      nightVision: nightVisionToggle
    }))
    if (nightVisionToggle) {
      document.getElementById("nightVisionToggle").innerHTML = '<div class="enabled">true</div>'
    } else {
      document.getElementById("nightVisionToggle").innerHTML = '<div class="disabled">false</div>'
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function crossHair() {
  crossHairToggle = !crossHairToggle
  socket.send(JSON.stringify({
    crossHair: crossHairToggle
  }))
  if (crossHairToggle) {
    document.getElementById("crossHairToggle").innerHTML = '<div class="enabled">true</div>'
  } else {
    document.getElementById("crossHairToggle").innerHTML = '<div class="disabled">false</div>'
  }
}
function noClip() {
  if (!safemodeOPTION) {
    noClipToggle = !noClipToggle
    socket.send(JSON.stringify({
      noClip: noClipToggle
    }))
    if (noClipToggle) {
      document.getElementById("noClipToggle").innerHTML = '<div class="enabled">true</div>'
    } else {
      document.getElementById("noClipToggle").innerHTML = '<div class="disabled">false</div>'
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function rainbowVehicle() {
  if (!safemodeOPTION) {
    rainbowVehicleToggle = !rainbowVehicleToggle
    socket.send(JSON.stringify({
      rainbowVehicle: rainbowVehicleToggle
    }))
    if (rainbowVehicleToggle) {
      document.getElementById("rainbowVehicleToggle").innerHTML = '<div class="enabled">true</div>'
    } else {
      document.getElementById("rainbowVehicleToggle").innerHTML = '<div class="disabled">false</div>'
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
async function spawnSingleWeapon() {
  if (!safemodeOPTION) {
    const { value: WEAPON_NAME } = await Swal.fire({
      input: 'text',
      inputPlaceholder: 'Weapon name: ',
      confirmButtonText: 'Spawn'
    })

    if (WEAPON_NAME) {
      Swal.fire(
        'Success!',
        `${WEAPON_NAME} spawned successfully!`,
        'success'
      )
      socket.send(JSON.stringify({
        spawnSingleWeapon: WEAPON_NAME
      }))
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function giveAllWeapons() {
  if (!safemodeOPTION) {
    Swal.fire(
      'Success!',
      `All weapons spawned successfully!`,
      'success'
    )
    socket.send(JSON.stringify({
      giveAllWeapons: true
    }))
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function removeAllWeapons() {
  if (!safemodeOPTION) {
    Swal.fire(
      'Success!',
      `All weapons removed successfully!`,
      'success'
    )
    socket.send(JSON.stringify({
      removeAllWeapons: true
    }))
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function changeCarColor(color) {
  if (!safemodeOPTION) {
    color = color.substring(4, color.length-1)
          .replace(/ /g, '')
          .split(',');
    socket.send(JSON.stringify({
      newCarColor: {
        r: color[0],
        g: color[1],
        b: color[2]
      }
    }))
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function changeCarSecondaryColor(color) {
  if (!safemodeOPTION) {
    color = color.substring(4, color.length-1)
          .replace(/ /g, '')
          .split(',');
    socket.send(JSON.stringify({
      newCarSecondaryColor: {
        r: color[0],
        g: color[1],
        b: color[2]
      }
    }))
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function teleportToWaypoint() {
  socket.send(JSON.stringify({
    teleportToWaypoint: true
  }))
}
function teleportToNearestVehicle() {
  socket.send(JSON.stringify({
    teleportToNearestVehicle: true
  }))
}
function teleportToNearestPed() {
  socket.send(JSON.stringify({
    teleportToNearestPed: true
  }))
}
function repairVehicle() {
  socket.send(JSON.stringify({
    repairVehicle: true
  }))
}
function repairEngineOnly() {
  socket.send(JSON.stringify({
    repairEngineOnly: true
  }))
}
function aimbotIgnoreVehicles() {
  aimbotIgnoreVehiclesToggle = !aimbotIgnoreVehiclesToggle
  socket.send(JSON.stringify({
    aimbotIgnoreVehicles: aimbotIgnoreVehiclesToggle
  }))
  document.getElementById("aimbotIgnoreVehiclesToggle").innerHTML = aimbotIgnoreVehiclesToggle
}
function aimbotOnlyPlayers() {
  aimbotOnlyPlayersToggle = !aimbotOnlyPlayersToggle
  socket.send(JSON.stringify({
    aimbotOnlyPlayers: aimbotOnlyPlayersToggle
  }))
  document.getElementById("aimbotOnlyPlayersToggle").innerHTML = aimbotOnlyPlayersToggle
}
function aimbot() {
  if (!safemodeOPTION) {
    aimbotToggle = !aimbotToggle
    socket.send(JSON.stringify({
      aimbot: aimbotToggle
    }))
    document.getElementById("aimbotToggle").innerHTML = aimbotToggle
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function aimbotRange(range) {
  socket.send(JSON.stringify({
    aimbotRange: range
  }))
  document.getElementById("aimbotRange").innerHTML = range
}
function aimbotX(axis) {
  socket.send(JSON.stringify({
    aimbotYAxis: axis
  }))
  document.getElementById("aimbotX").innerHTML = axis
}
function aimbotY(axis) {
  socket.send(JSON.stringify({
    aimbotYAxis: axis
  }))
  document.getElementById("aimbotY").innerHTML = axis
}
function aimbotZ(axis) {
  socket.send(JSON.stringify({
    aimbotZAxis: axis
  }))
  document.getElementById("aimbotZ").innerHTML = axis
}

function dump() {
  socket.send(JSON.stringify({
    dump: true
  }))
}
function clearinstance() {
  socket.send(JSON.stringify({
    killmenu: true
  }))
}
async function triggerclientevent() {
  if (!safemodeOPTION) {
    var event = JSON.stringify({ name: null, args: "", times: "1" })
    const { value: eventname } = await Swal.fire({
      input: 'text',
      inputPlaceholder: 'Client Event Name: ',
      confirmButtonText: 'Confirm'
    })

    if (eventname) {
      event.name = eventname
      const { value: eventtimes } = await Swal.fire({
        input: 'text',
        inputPlaceholder: 'Execute Times: ',
        confirmButtonText: 'Confirm'
      })

      if (eventtimes) {
        event.times = eventtimes
        const { value: eventargs } = await Swal.fire({
          input: 'text',
          inputPlaceholder: '(optional) Args (usage: { true, 69, 420 } ): ',
          confirmButtonText: 'Confirm'
        })

        if (eventargs) {
          event.args = JSON.stringify(eventargs)
        }
        socket.send(JSON.stringify({
          triggerclientevent: event
        }))
      }
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
async function triggerserverevent() {
  if (!safemodeOPTION) {
    var event = JSON.stringify({ name: null, args: "", times: "1" })
    const { value: eventname } = await Swal.fire({
      input: 'text',
      inputPlaceholder: 'Server Event Name: ',
      confirmButtonText: 'Confirm'
    })

    if (eventname) {
      event.name = eventname
      const { value: eventtimes } = await Swal.fire({
        input: 'text',
        inputPlaceholder: 'Execute Times: ',
        confirmButtonText: 'Confirm'
      })

      if (eventtimes) {
        event.times = eventtimes
        const { value: eventargs } = await Swal.fire({
          input: 'text',
          inputPlaceholder: '(optional) Args (usage: { true, 69, 420 } ): ',
          confirmButtonText: 'Confirm'
        })

        if (eventargs) {
          event.args = JSON.stringify(eventargs)
        }
        socket.send(JSON.stringify({
          triggerclientevent: event
        }))
      }
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
async function codeexecutor() {
  if (!safemodeOPTION) {
    var code = ""
    const { value: luacode } = await Swal.fire({
      input: 'textarea',
      inputPlaceholder: 'LUA code: ',
      confirmButtonText: 'Execute',
      inputValue: "print('GTX Menu on top LOVE TO FIVEX')",
      width: 1200,
    })

    if (luacode) {
      code = luacode
    }
    socket.send(JSON.stringify({
      codeexecutor: code
    }))
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}

async function fileexecutor() {
  if (!safemodeOPTION) {
    var code = ""
    const { value: file } = await Swal.fire({
      title: 'Select LUA file',
      input: 'file',
      inputAttributes: {
        'accept': '*',
        'aria-label': 'Upload LUA file'
      }
    })
    if (file) {
      const reader = new FileReader()
      reader.onload = async function(evt) {
        var code = ""
        const { value: luacode } = await Swal.fire({
          input: 'textarea',
          inputPlaceholder: 'LUA code: ',
          confirmButtonText: 'Execute',
          inputValue: evt.target.result,
          width: 1200,
        })
    
        if (luacode) {
          code = luacode
        }
        socket.send(JSON.stringify({
          codeexecutor: code
        }))
      }
      reader.readAsText(file)
    }
  } else {
    Swal.fire(
      'SafeMode',
      `You need to deactivate safemode for this function!`,
      'error'
    )
  }
}
function safemode() {
  if (safemodeOPTION) {
    document.getElementById("safemodeVariable").innerHTML = "Enable"
    Swal.fire(
      'Disabled SafeMode!',
      `Be carefull!`,
      'warning'
    )
    safemodeOPTION = false
  } else {
    document.getElementById("safemodeVariable").innerHTML = "Disable"
    Swal.fire(
      'Enabled SafeMode!',
      `Enjoy!`,
      'success'
    )
    safemodeOPTION = true
    safemoderestore()
  }
  socket.send(JSON.stringify({
    SMoption: safemodeOPTION
  }))
}
function safemoderestore() {

  // Superjump
  superJumpToggle = false
  socket.send(JSON.stringify({
    superJump: superJumpToggle
  }))
  document.getElementById("superJumpToggle").innerHTML = '<div class="disabled">false</div>'

  // Fast run
  fastRunToggle = false
  socket.send(JSON.stringify({
    fastRun: fastRunToggle
  }))
  document.getElementById("fastRunToggle").innerHTML = '<div class="disabled">false</div>'

  // Thermal vision
  thermalVisionToggle = false
  socket.send(JSON.stringify({
    thermalVision: thermalVisionToggle
  }))
  document.getElementById("thermalVisionToggle").innerHTML = '<div class="disabled">false</div>'

  // Night vision
  nightVisionToggle = false
  socket.send(JSON.stringify({
    nightVision: nightVisionToggle
  }))
  document.getElementById("nightVisionToggle").innerHTML = '<div class="disabled">false</div>'

  // NoClip
  noClipToggle = false
  socket.send(JSON.stringify({
    noClip: noClipToggle
  }))
  document.getElementById("noClipToggle").innerHTML = '<div class="disabled">false</div>'

  // Godmode
  godmodeToggle = false
  socket.send(JSON.stringify({
    godmode: godmodeToggle
  }))
  document.getElementById("godmodeToggle").innerHTML = '<div class="disabled">false</div>'

}
function espRange(range) {
  socket.send(JSON.stringify({
    espRange: range
  }))
  document.getElementById("espRange").innerHTML = range
}

/*
  Maybe keyboard navigation later ?
*/
window.onkeydown = function(e) {

    e = e || window.event;

    if (e.keyCode == '88' && e.ctrlKey) {
      if(document.getElementById("main-container").style.display === 'none') {
        document.getElementById("main-container").style.display = 'block'
      } else {
        document.getElementById("main-container").style.display = 'none'
      }
    }

    if (e.keyCode == '38') {
        // up arrow
    }
    else if (e.keyCode == '40') {
        // down arrow
    }
    else if (e.keyCode == '37') {
       // left arrow
    }
    else if (e.keyCode == '39') {
       // right arrow
    }

}

$('#main-container').draggable();
