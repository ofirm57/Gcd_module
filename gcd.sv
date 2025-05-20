module gcd(
    input logic clk ,
    input logic resetb ,
    input logic [7:0] u, //Unsigned greater than 0 number
    input logic [7:0] v, //Unsigned greater than 0 number
    input logic ld , 
    output logic [7:0] res,
    output logic done
);

logic [7:0] tmp_v,tmp_u;
// logic [7:0] tmp_res;
logic [2:0] counter;




typedef enum logic [1:0] {
    IDLE = 2'b00,
    LODE = 2'b01,
    CALC = 2'b10,
    DONE = 2'b11
}my_state;

my_state cs,ns;

always_ff @(posedge clk or negedge resetb)
 if(~resetb)
    cs <= IDLE;
 else
    cs <= ns;


always_comb 
case(cs)
    IDLE: ns = ld ? LODE : IDLE;
    LODE: ns = CALC;
    // CALC: ns = done ? DONE :CALC;
    CALC: ns = (tmp_u == tmp_v) ? DONE :CALC;
    DONE: ns = IDLE;
    default ns = IDLE;
endcase

// always_comb     ///LODE
// if(cs == LODE )
// begin
//     tmp_v = v;
//     tmp_u = u;
//     counter =3'b0;
//     done = 1'b0;
// end


// always_comb    //CALC
// if(cs == CALC)
// begin
// if (tmp_v != tmp_u)
//     begin
//     if(tmp_v[0] == 1'b0 && tmp_u[0] == 1'b0)// A - if both are even
//         begin
//         tmp_v = tmp_v >> 1'b1;
//         tmp_u = tmp_u >> 1'b1;
//         counter = counter +  3'b001;
//         end
//     else if(tmp_v[0] == 1'b0 | tmp_u[0] == 1'b0)// B - if only 1 is even
//         begin
//         if(tmp_v[0] == 1'b0 )
//             tmp_v = tmp_v >> 1'b1;
//         else
//             tmp_u = tmp_u >> 1'b1;
//         end

//     else if(tmp_v[0] == 1'b1 && tmp_u[0] == 1'b1) // C - both, u and v, are odd
//         begin
//         if (tmp_u>tmp_v)
//             tmp_u = tmp_u - tmp_v;
//             else
//             tmp_v = tmp_v - tmp_u;
//         end

//     // else if(tmp_v == 8'b0000_0001 | tmp_u == 8'b0000_0001 ) 
//     // tmp_res = 8'b0000_0001 << counter; ;
//     // done = 1'b1;
//     // end

// else // if (tmp_v == tmp_u)
//     begin
//     tmp_res = tmp_u << counter;
//     done = 1'b1;
//     end
// end

/////////////////

always_ff @(posedge clk or negedge resetb)
 if(~resetb)
  begin
    tmp_res <= 8'b0;
    tmp_v <= 8'b0;
    tmp_u <= 8'b0;
    counter <= 3'b0;
    done <= 1'b0;
 end
    else
    begin
        case(cs)
            LODE : 
                begin   
                tmp_v <= v;
                tmp_u <= u;
                counter <=3'b0;
                done <= 1'b0;
                end

            CALC:
                begin
                if (tmp_v != tmp_u)
                begin
                    if(tmp_v[0] == 1'b0 && tmp_u[0] == 1'b0)// A - if both are even
                        begin
                        tmp_v <= tmp_v >> 1'b1;
                        tmp_u <= tmp_u >> 1'b1;
                        counter <= counter +  3'b001;
                        end

                    else if(tmp_v[0] == 1'b0 || tmp_u[0] == 1'b0)// B - if only 1 is even
                        begin
                        if(tmp_v[0] == 1'b0 )
                            tmp_v <= tmp_v >> 1'b1;
                        else
                            tmp_u <= tmp_u >> 1'b1;
                        end

                    else if(tmp_v[0] == 1'b1 && tmp_u[0] == 1'b1) // C - both, u and v, are odd
                        begin
                        if (tmp_u > tmp_v)
                            tmp_u <= tmp_u - tmp_v;
                            else
                            tmp_v <= tmp_v - tmp_u;
                        end

                    // else // if (tmp_v == tmp_u)
                    //     begin
                    //     tmp_res <= tmp_u << counter;
                    //     done <= 1'b1;
                    //     end

                end
                end
            DONE :
                begin
                res <= tmp_u << counter;
                done <= 1'b1;
                end
        endcase
    end
        

///////////////////

// assign  res = (cs == DONE) ? tmp_res: 8'b0;


endmodule//gcd



