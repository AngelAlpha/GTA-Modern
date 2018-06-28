local vehicles =
{
    [ 400 ] = true,
    [ 401 ] = true,
    [ 402 ] = true,
    [ 403 ] = true,
    [ 404 ] = true,
    [ 405 ] = true,
    [ 409 ] = true,
    [ 410 ] = true,
    [ 415 ] = true,
    [ 411 ] = true,
    [ 412 ] = true,
    [ 413 ] = true,
    [ 415 ] = true,
    [ 416 ] = true,
    [ 418 ] = true,
    [ 419 ] = true,
    [ 420 ] = true,
    [ 421 ] = true,
    [ 422 ] = true,
    [ 423 ] = true,
    [ 426 ] = true,
    [ 428 ] = true,
    [ 429 ] = true,
    [ 431 ] = true,
    [ 434 ] = true,
    [ 436 ] = true,
    [ 437 ] = true,
    [ 438 ] = true,
    [ 439 ] = true,
    [ 440 ] = true,
    [ 442 ] = true,
    [ 445 ] = true,
    [ 446 ] = true,
    [ 451 ] = true,
    [ 458 ] = true,
    [ 459 ] = true,
    [ 466 ] = true,
    [ 467 ] = true,
    [ 470 ] = true,
    [ 474 ] = true,
    [ 475 ] = true,
    [ 477 ] = true,
    [ 479 ] = true,
    [ 480 ] = true,
    [ 482 ] = true,
    [ 483 ] = true,
    [ 489 ] = true,
    [ 490 ] = true,
    [ 491 ] = true,
    [ 492 ] = true,
    [ 494 ] = true,
    [ 495 ] = true,
    [ 496 ] = true,
    [ 498 ] = true,
    [ 499 ] = true,
    [ 500 ] = true,
    [ 502 ] = true,
    [ 503 ] = true,
    [ 504 ] = true,
    [ 505 ] = true,
    [ 506 ] = true,
    [ 507 ] = true,
    [ 508 ] = true,
    [ 516 ] = true,
    [ 517 ] = true,
    [ 518 ] = true,
    [ 525 ] = true,
    [ 526 ] = true,
    [ 527 ] = true,
    [ 528 ] = true,
    [ 529 ] = true,
    [ 533 ] = true,
    [ 534 ] = true,
    [ 535 ] = true,
    [ 536 ] = true,
    [ 540 ] = true,
    [ 541 ] = true,
    [ 542 ] = true,
    [ 543 ] = true,
    [ 545 ] = true,
    [ 546 ] = true,
    [ 547 ] = true,
    [ 549 ] = true,
    [ 550 ] = true,
    [ 551 ] = true,
    [ 552 ] = true,
    [ 554 ] = true,
    [ 555 ] = true,
    [ 558 ] = true,
    [ 559 ] = true,
    [ 560 ] = true,
    [ 561 ] = true,
    [ 562 ] = true,
    [ 565 ] = true,
    [ 566 ] = true,
    [ 567 ] = true,
    [ 568 ] = true,
    [ 575 ] = true,
    [ 576 ] = true,
    [ 579 ] = true,
    [ 580 ] = true,
    [ 582 ] = true,
    [ 585 ] = true,
    [ 587 ] = true,
    [ 588 ] = true,
    [ 589 ] = true,
    [ 596 ] = true,
    [ 597 ] = true,
    [ 598 ] = true,
    [ 599 ] = true,
    [ 600 ] = true,
    [ 602 ] = true,
    [ 603 ] = true,
    [ 604 ] = true,
    [ 605 ] = true,
    [ 609 ] = true
}

function porta1()
local vehicle = getPedOccupiedVehicle(source)
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 0 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 0, 1, 2500)
    else
        setVehicleDoorOpenRatio(vehicle, 0, 0, 2500)
    end
end
addEvent("porta1", true)
addEventHandler("porta1", root, porta1)

function porta6()
local vehicle = getPedOccupiedVehicle(source)
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 1 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 1, 1, 2500)
    else
        setVehicleDoorOpenRatio(vehicle, 1, 0, 2500)
    end
end
addEvent("porta2", true)
addEventHandler("porta2", root, porta6)

function porta6_2()
local vehicle = getPedOccupiedVehicle(source)
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 1 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 1, 1-0.7, 2500)
    else
        setVehicleDoorOpenRatio(vehicle, 1, 0, 2500)
    end
end
addEvent("porta2_2", true)
addEventHandler("porta2_2", root, porta6_2)

function porta2()
local vehicle = getPedOccupiedVehicle(source)
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 2 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 2, 1, 2500)
    else
        setVehicleDoorOpenRatio(vehicle, 2, 0, 2500)
    end
end
addEvent("porta3", true)
addEventHandler("porta3", root, porta2)

function porta3()
local vehicle = getPedOccupiedVehicle(source)
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 4 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 4, 1, 2500)
    else
        setVehicleDoorOpenRatio(vehicle, 4, 0, 2500)
    end
end
addEvent("porta4", true)
addEventHandler("porta4", root, porta3)

function porta4()
local vehicle = getPedOccupiedVehicle(source)
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 3 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 3, 1, 2500)
    else
        setVehicleDoorOpenRatio(vehicle, 3, 0, 2500)
    end
end
addEvent("porta5", true)
addEventHandler("porta5", root, porta4)

function porta5()
local vehicle = getPedOccupiedVehicle(source)
if not vehicle then return end
    if getVehicleDoorOpenRatio ( vehicle, 5 ) == 0 then
        setVehicleDoorOpenRatio(vehicle, 5, 1, 2500)
    else
        setVehicleDoorOpenRatio(vehicle, 5, 0, 2500)
    end
end
addEvent("porta6", true)
addEventHandler("porta6", root, porta5)