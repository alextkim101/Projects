import React from "react";
import { Marker, InfoWindow } from "react-google-maps";

export default class EventInfoMap extends React.Component {

  handleClick = (index) => {
    this.props.showInfo(index);
    this.props.onMarkerClick(index);
  }

  render() {
    const markers = this.props.events.map((event, index) => (
        <Marker
          key={index}
          position={{ lat: event.lat, lng: event.lng }}
          onClick={() => this.handleClick(index)}
        >
          {(this.props.infoIndex === index && this.props.isOpen) &&
            <InfoWindow
              onCloseClick={this.props.handleToggleOpen}
              options={{ maxWidth: 400 }}
            >
              <div className="col-md-12">
                <div className="featured-place-wrap-non-hover">
                  <img src="images/featured1.jpg" className="img-fluid" alt="#" />
                  <div className="featured-title-box">
                    <h6>{event.title}</h6>
                    <ul>
                      <li><span className="icon-clock" />
                        <p>{event.date}, {event.time}</p>
                      </li>
                      <li><span className="icon-location-pin" />
                        <p>{event.location}</p>
                      </li>
                      <li><span className="icon-note" />
                        <p>{event.descript}</p>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </InfoWindow>}
        </Marker>
    ));
    return (
      <div>
        {markers}
      </div>
    );
  }

}