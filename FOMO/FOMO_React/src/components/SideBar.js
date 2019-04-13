import React from "react";
import SideBarItem from "./SideBarItem";

export default class SideBar extends React.Component {

  onNext = () => {
    this.props.onNext();
  }

  onPrev = () => {
    this.props.onPrev();
  }

  render() {
    const SideBarItems = this.props.events.map((event, index) => (
      <SideBarItem
        key={index}
        onCloseClick={this.props.handleToggleOpen}
        onClick={this.props.showInfo}
        onMarkerClick={this.props.onMarkerClick}
        event={event}
        id={index}
        isOpen={this.props.isOpen}
        infoIndex={this.props.infoIndex}
      />
    ));

    return (
      <div className="row">
        <div className="light-bg detail-options-wrap scrollable">
          {SideBarItems}
          <div className="col-md-12">
            <nav>
              <ul className="pagination justify-content-center pagination-lg">
              <li 
                  className={this.props.hasPrev ? "page-item" : "page-item disabled"} 
                  onClick={this.props.hasPrev ? this.onPrev : null}
                >
                  <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                    <span className="sr-only">Previous</span>
                  </a>
                </li>
                <li 
                  className={this.props.hasNext ? "page-item" : "page-item disabled"} 
                  onClick={this.props.hasNext ? this.onNext : null}
                >
                  <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&raquo;</span>
                    <span class="sr-only">Next</span>
                  </a>
                </li>

              </ul>
            </nav>
          </div>
        </div>
      </div>
    );
  }
}