//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

#include "PathTrain.h"
#include <stdio.h>
#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;


PathTrain::PathTrain() {
    msgServiced = endServiceMsg = nullptr;
}

PathTrain::~PathTrain() {
    delete msgServiced;
    cancelAndDle(endServiceMsg);
}

class Source: public cSimpleModule {
private:
    int jobsLeft;
    int trainsInSystem;
    int maxTrainsInSystem;

public:
    Source();
    virtual ~Source();

protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
};

Define_Module(Source);

void Source::initialize() {

    // Generate and send Path Train

    //maxTrainsInSystem is the number of path trains between the
    //two stations
    maxTrainsInSystem = par("maxTrains"); //read the value from the
                                   //ARQ.ned declared parameter



    counter = num_packets;
    EV << "Train embarking from Hoboken to 33rd and back again\n";
    cPacket *pkt = new cPacket("packet");
    pkt->setBitLength(100);
    send(pkt, "out");
    counter--;
    }
}

void Source::handleMessage(cMessage *msg) {

}


class Destination: public cSimpleModule {
protected:
    cStdDev delayStats;
    cDoubleHistogram histogram;
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual void finish() override;
};

Define_Module(Destination);

void Destination::initialize() {
    delayStats.setName("Delay");
    //histogram.setNumCells(20);
    //histogram.setRangeAuto(50, 1.5);
    histogram.setRange(0, 1);
    histogram.setNumCells(10);

}

void Destination::handleMessage(cMessage *msg) {
    cPacket* pkt = check_and_cast<cPacket *>(msg);
    if (pkt->hasBitError()) {
        EV << "Packet received in error";
        pkt->setKind(1); //kind =1 means NACK
    } else {
        EV << "Sending back same message as ACK.\n";
        pkt->setKind(0); // kind=0 - means ACK - we need to collect statistics
        simtime_t delay = simTime() - pkt->getCreationTime();
        EV << "delay =  ";
        EV << delay;
        delayStats.collect(delay);
        histogram.collect(delay);
    }
    send(pkt, "out");
}

void Destination::finish() {
    recordScalar("mean delay", delayStats.getMean());
    recordScalar("max delay", delayStats.getMax());
    recordScalar("std deviation", delayStats.getStddev());
    recordScalar("variance", delayStats.getVariance());
    histogram.record();
    //test if the selected range was appropriate:
    EV << "histogram number of overflows =";
    EV << histogram.getOverflowCell();
}



