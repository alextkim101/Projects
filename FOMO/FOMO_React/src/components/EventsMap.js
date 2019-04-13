import React from "react";
import { withScriptjs, withGoogleMap, GoogleMap } from "react-google-maps";
import EventInfoMap from "./EventInfoMap";

const EventsMap = withScriptjs(withGoogleMap((props) => {

  return (
    <GoogleMap
      defaultZoom={16}
      center={props.mapCenter}
    >
      <EventInfoMap {...props} />
    </GoogleMap>
  );
}
))


export default EventsMap;