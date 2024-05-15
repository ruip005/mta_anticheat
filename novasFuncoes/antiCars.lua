-- Server-side
local server_vehicles = { };

function create( model_id, x, y, z, ... )
    local veh = createVehicle( model_id, x, y, z, ... );
    if ( veh ) then
        server_vehicles[ veh ] = true;
        return veh;
    end
    return false;
end

function destroy( vehicle )
    if ( not isElement( vehicle ) ) or ( not server_vehicles[ vehicle ] ) then
        return false;
    end

    server_vehicles[ vehicle ] = nil;
    destroyElement( vehicle );
end

addEventHandler( "onVehicleEnter", root, function( player )
    if ( not server_vehicles[ source ] ) then
        -- Algo tá errado, já que o veículo não existe, possivelmente cheat.
    end
end );
