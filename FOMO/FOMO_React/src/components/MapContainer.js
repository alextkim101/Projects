import React from "react";
import Config from "../../config";
import EventsMap from "./EventsMap";


class MapContainer extends React.PureComponent {

  render() {
    return (
      <EventsMap
        {...this.props}
        
        googleMapURL={`https://maps.googleapis.com/maps/api/js?key=${Config.apiKey}&v=3.exp&libraries=geometry,drawing,places`}
        loadingElement={<div style={{ height: `100%` }} />}
        containerElement={<div style={{ height: `100%`, width: "100%" }} />}
        mapElement={<div style={{ height: `100%` }} />}
      />
    )
  }
}

export default MapContainer;