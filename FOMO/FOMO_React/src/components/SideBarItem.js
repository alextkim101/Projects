import React from "react";

export default class SideBarItem extends React.Component {
    handleClick = () => {
        this.props.onClick(this.props.id);
        this.props.onMarkerClick(this.props.id)
    }

    handleCloseClick = () => {
        this.props.onCloseClick();
    }

    render() {
        let name = this.props.id.toString();
        if (this.props.infoIndex === this.props.id && this.props.isOpen) {
            return (
                <div className="col-md-12 featured-responsive"
                    onClick={this.handleCloseClick}
                    style={{ cursor: "pointer" }}
                    id={name}>
                    <div className="featured-place-wrap featured-place-wrap-active">
                        <img src="images/featured1.jpg" className="img-fluid" alt="#" />
                        <div className="featured-title-box">
                            <h6 className="custom">{this.props.event.title}</h6>
                            <ul>
                                <li><span className="icon-clock custom" />
                                    <p className="custom">{this.props.event.date}, {this.props.event.time}</p>
                                </li>
                                <li><span className="icon-location-pin custom" />
                                    <p className="custom">{this.props.event.location}</p>
                                </li>
                                <li><span className="icon-note custom" />
                                    <p className="custom">{this.props.event.descript}</p>
                                </li>
                            </ul>
                            <div className="bottom-icons">
                                <span className="ti-heart custom" />
                                <span className="ti-bookmark custom" />
                            </div>
                        </div>
                    </div>
                </div>
            );
        }
        return (
            <div className="col-md-12 featured-responsive" 
                onClick={this.handleClick} 
                style={{ cursor: "pointer" }}
                id={name}>
                <div className="featured-place-wrap">
                    <img src="images/featured1.jpg" className="img-fluid" alt="#" />
                    <div className="featured-title-box">
                        <h6 className="custom">{this.props.event.title}</h6>
                        <ul>
                            <li><span className="icon-clock custom" />
                                <p className="custom">{this.props.event.date}, {this.props.event.time}</p>
                            </li>
                            <li><span className="icon-location-pin custom" />
                                <p className="custom">{this.props.event.location}</p>
                            </li>
                            <li><span className="icon-note custom" />
                                <p className="custom">{this.props.event.descript}</p>
                            </li>
                        </ul>
                        <div className="bottom-icons">
                            <span className="ti-heart custom" />
                            <span className="ti-bookmark custom" />
                        </div>
                    </div>
                </div>
            </div>
        );
    }

}