import org.omnetpp.queueing.Delay;
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
import org.omnetpp.queueing.PassiveQueue;
import org.omnetpp.queueing.Queue;
import org.omnetpp.queueing.Server;
import org.omnetpp.queueing.Sink;
import org.omnetpp.queueing.Source;


//
// TODO documentation
//
network Network
{
    @display("bgb=850.3137,565.0612");
    submodules:
        source: Source {
            @display("p=49,54");
        }
        server: Server {
            @display("p=151.33624,226.45999;t=Hoboken");
        }
        server1: Server {
            @display("p=151.33624,513.89;t=Christopher St");
        }
        server2: Server {
            @display("p=258.03375,327.71375;t=9th St");
        }
        server3: Server {
            @display("p=259,54;t=14th St");
        }
        server4: Server {
            @display("p=366.90875,226.45999;t=23rd St");
        }
        server5: Server {
            @display("p=366.90875,513.89;t=33rd St");
        }
        server6: Server {
            @display("p=465.985,327.71375;t=23rd St");
        }
        server7: Server {
            @display("p=467,54;t=14th St");
        }
        server8: Server {
            @display("p=561.795,226.45999;t=9th St");
        }
        server9: Server {
            @display("p=561.795,513.89;t=Christopher St");
        }
        server10: Server {
            @display("p=649.98376,327.71375;t=Hoboken");
        }
        queue: PassiveQueue {
            @display("p=152,54");
        }
        queue1: PassiveQueue {
            @display("p=151.33624,327.71375");
        }
        queue2: PassiveQueue {
            @display("p=258.03375,513.89");
        }
        queue3: PassiveQueue {
            @display("p=258.03375,226.45999");
        }
        queue4: PassiveQueue {
            @display("p=367,54");
        }
        queue5: PassiveQueue {
            @display("p=366.90875,327.71375");
        }
        queue6: PassiveQueue {
            @display("p=465.985,513.89");
        }
        queue7: PassiveQueue {
            @display("p=465.985,226.45999");
        }
        queue8: PassiveQueue {
            @display("p=562,54");
        }
        queue9: PassiveQueue {
            @display("p=561.795,327.71375");
        }
        queue10: PassiveQueue {
            @display("p=649.98376,513.89");
        }
        sink: Sink {
            @display("p=762.125,327.71375");
        }
        delay: Delay {
            @display("p=151.33624,140.44875");
        }
        delay1: Delay {
            @display("p=151.33624,423.52374");
        }
        delay2: Delay {
            @display("p=258.03375,423.52374");
        }
        delay3: Delay {
            @display("p=258.03375,140.44875");
        }
        delay4: Delay {
            @display("p=366.90875,140.44875");
        }
        delay5: Delay {
            @display("p=366.90875,423.52374");
        }
        delay6: Delay {
            @display("p=465.985,423.52374");
        }
        delay7: Delay {
            @display("p=465.985,140.44875");
        }
        delay8: Delay {
            @display("p=561.795,140.44875");
        }
        delay9: Delay {
            @display("p=561.795,423.52374");
        }
        delay10: Delay {
            @display("p=649.98376,423.52374");
        }
    connections:
        server4.out --> queue5.in++;
        server5.out --> queue6.in++;
        server6.out --> queue7.in++;
        server7.out --> queue8.in++;
        server8.out --> queue9.in++;
        server9.out --> queue10.in++;

        queue1.out++ --> delay1.in++;
        delay1.out --> server1.in++;
        queue.out++ --> delay.in++;
        delay.out --> server.in++;
        queue2.out++ --> delay2.in++;
        delay2.out --> server2.in++;
        queue3.out++ --> delay3.in++;
        delay3.out --> server3.in++;
        queue4.out++ --> delay4.in++;
        delay4.out --> server4.in++;
        queue5.out++ --> delay5.in++;
        delay5.out --> server5.in++;
        queue6.out++ --> delay6.in++;
        delay6.out --> server6.in++;
        queue7.out++ --> delay7.in++;
        delay7.out --> server7.in++;
        queue8.out++ --> delay8.in++;
        queue9.out++ --> delay9.in++;
        delay9.out --> server9.in++;
        queue10.out++ --> delay10.in++;
        delay10.out --> server10.in++;
        source.out --> queue.in++;
        server10.out --> sink.in++;
        server.out --> queue1.in++;
        server3.out --> queue4.in++;
        server2.out --> queue3.in++;
        server1.out --> queue2.in++;
        delay8.out --> server8.in++;
}

