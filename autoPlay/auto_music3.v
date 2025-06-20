module auto_music3(
    input clk,
    input pause,
    input rst_n,
    input return,
    output buzzer,
    output reg get_pause,
    output reg get_return
);

parameter N = 4686914;

reg [21:0] cnt;

reg clk_spec;

reg [31:0] j;

reg [26:0] counter;


always @(posedge clk) begin
    if(counter<N)begin
        counter<=counter+1;
        clk_spec<=clk_spec;
    end
    else begin
        counter<=0;
        clk_spec<=~clk_spec;
    end
end


reg [31:0] j_;

always @(posedge clk_spec or posedge pause) begin
    if(pause)begin
        j_<=j_;
        get_pause<=1;
    end
    else if(j_<357) begin
        j_<=j_+1;
        get_pause<=0;
    end
    else begin
        j_<=0;
        get_pause<=0;
    end
end

always@(*)begin
	if(pause) j=500;
	else if(!rst_n) j=500;
	else j=j_;
end

reg [4:0] note;

always @(*) begin
    case(j)
0:note=5'b10001;
1:note=5'b10001;
2:note=5'b10000;
3:note=5'b10000;
4:note=5'b10100;
5:note=5'b10100;
6:note=5'b10000;
7:note=5'b10000;
8:note=5'b10001;
9:note=5'b10001;
10:note=5'b10000;
11:note=5'b10000;
12:note=5'b01101;
13:note=5'b01101;
14:note=5'b10000;
15:note=5'b10000;
16:note=5'b10001;
17:note=5'b10001;
18:note=5'b10000;
19:note=5'b10000;
20:note=5'b10100;
21:note=5'b10100;
22:note=5'b10000;
23:note=5'b10000;
24:note=5'b10001;
25:note=5'b10001;
26:note=5'b10000;
27:note=5'b10000;
28:note=5'b01101;
29:note=5'b01101;
30:note=5'b10000;
31:note=5'b10000;
32:note=5'b10001;
33:note=5'b10001;
34:note=5'b10000;
35:note=5'b10000;
36:note=5'b10100;
37:note=5'b10100;
38:note=5'b10000;
39:note=5'b10000;
40:note=5'b10001;
41:note=5'b10001;
42:note=5'b10000;
43:note=5'b10000;
44:note=5'b01101;
45:note=5'b01101;
46:note=5'b10000;
47:note=5'b10000;
48:note=5'b10001;
49:note=5'b10001;
50:note=5'b10000;
51:note=5'b10000;
52:note=5'b10100;
53:note=5'b10100;
54:note=5'b10000;
55:note=5'b10000;
56:note=5'b10001;
57:note=5'b10001;
58:note=5'b10000;
59:note=5'b10000;
60:note=5'b01101;
61:note=5'b01101;
62:note=5'b10000;
63:note=5'b10000;
64:note=5'b10001;
65:note=5'b10100;
66:note=5'b10111;
67:note=5'b11000;
68:note=5'b10001;
69:note=5'b10001;
70:note=5'b10001;
71:note=5'b10001;
72:note=5'b00000;
73:note=5'b01101;
74:note=5'b01111;
75:note=5'b10001;
76:note=5'b10000;
77:note=5'b10000;
78:note=5'b10000;
79:note=5'b10000;
80:note=5'b10011;
81:note=5'b10011;
82:note=5'b10011;
83:note=5'b10011;
84:note=5'b10000;
85:note=5'b10000;
86:note=5'b10000;
87:note=5'b10101;
88:note=5'b10100;
89:note=5'b10100;
90:note=5'b10100;
91:note=5'b10011;
92:note=5'b10100;
93:note=5'b10100;
94:note=5'b10100;
95:note=5'b10100;
96:note=5'b11000;
97:note=5'b11000;
98:note=5'b11000;
99:note=5'b11000;
100:note=5'b10100;
101:note=5'b10100;
102:note=5'b10100;
103:note=5'b10100;
104:note=5'b11000;
105:note=5'b11000;
106:note=5'b11000;
107:note=5'b11000;
108:note=5'b10111;
109:note=5'b10111;
110:note=5'b10111;
111:note=5'b11000;
112:note=5'b10111;
113:note=5'b10101;
114:note=5'b10101;
115:note=5'b10011;
116:note=5'b10011;
117:note=5'b10100;
118:note=5'b10100;
119:note=5'b10100;
120:note=5'b10100;
121:note=5'b10100;
122:note=5'b10100;
123:note=5'b10100;
124:note=5'b10100;
125:note=5'b10100;
126:note=5'b10100;
127:note=5'b10100;
128:note=5'b10100;
129:note=5'b00000;
130:note=5'b00000;
131:note=5'b10001;
132:note=5'b10001;
133:note=5'b10001;
134:note=5'b10001;
135:note=5'b10001;
136:note=5'b10001;
137:note=5'b10001;
138:note=5'b00000;
139:note=5'b01101;
140:note=5'b01111;
141:note=5'b10001;
142:note=5'b10000;
143:note=5'b10000;
144:note=5'b10000;
145:note=5'b10000;
146:note=5'b10011;
147:note=5'b10011;
148:note=5'b10011;
149:note=5'b10011;
150:note=5'b10000;
151:note=5'b10000;
152:note=5'b10011;
153:note=5'b10011;
154:note=5'b10100;
155:note=5'b10100;
156:note=5'b10101;
157:note=5'b10101;
158:note=5'b10001;
159:note=5'b10110;
160:note=5'b10000;
161:note=5'b10101;
162:note=5'b01111;
163:note=5'b10100;
164:note=5'b01110;
165:note=5'b10011;
166:note=5'b10100;
167:note=5'b11000;
168:note=5'b10111;
169:note=5'b11000;
170:note=5'b10100;
171:note=5'b11000;
172:note=5'b10111;
173:note=5'b11000;
174:note=5'b10100;
175:note=5'b11000;
176:note=5'b10111;
177:note=5'b11000;
178:note=5'b10100;
179:note=5'b11000;
180:note=5'b10111;
181:note=5'b11000;
182:note=5'b10100;
183:note=5'b11000;
184:note=5'b10110;
185:note=5'b11000;
186:note=5'b10100;
187:note=5'b11000;
188:note=5'b10110;
189:note=5'b11000;
190:note=5'b10100;
191:note=5'b11000;
192:note=5'b10110;
193:note=5'b11000;
194:note=5'b10100;
195:note=5'b10100;
196:note=5'b10001;
197:note=5'b10001;
198:note=5'b10110;
199:note=5'b10001;
200:note=5'b10101;
201:note=5'b10001;
202:note=5'b10110;
203:note=5'b10001;
204:note=5'b10111;
205:note=5'b10001;
206:note=5'b10101;
207:note=5'b10001;
208:note=5'b10100;
209:note=5'b10001;
210:note=5'b10011;
211:note=5'b10011;
212:note=5'b10001;
213:note=5'b10011;
214:note=5'b10100;
215:note=5'b01111;
216:note=5'b10011;
217:note=5'b01111;
218:note=5'b10100;
219:note=5'b01111;
220:note=5'b10110;
221:note=5'b01111;
222:note=5'b10011;
223:note=5'b01111;
224:note=5'b10010;
225:note=5'b01111;
226:note=5'b10001;
227:note=5'b10001;
228:note=5'b10001;
229:note=5'b10011;
230:note=5'b10010;
231:note=5'b01101;
232:note=5'b10001;
233:note=5'b10000;
234:note=5'b01101;
235:note=5'b10010;
236:note=5'b01101;
237:note=5'b10001;
238:note=5'b01101;
239:note=5'b10000;
240:note=5'b01101;
241:note=5'b01111;
242:note=5'b01101;
243:note=5'b10001;
244:note=5'b01101;
245:note=5'b10000;
246:note=5'b01011;
247:note=5'b01111;
248:note=5'b01011;
249:note=5'b01110;
250:note=5'b01011;
251:note=5'b01101;
252:note=5'b01011;
253:note=5'b01100;
254:note=5'b01100;
255:note=5'b01101;
256:note=5'b01101;
257:note=5'b01110;
258:note=5'b01110;
259:note=5'b01010;
260:note=5'b01010;
261:note=5'b01111;
262:note=5'b01010;
263:note=5'b01110;
264:note=5'b01010;
265:note=5'b01111;
266:note=5'b01010;
267:note=5'b10000;
268:note=5'b01010;
269:note=5'b01110;
270:note=5'b01010;
271:note=5'b01101;
272:note=5'b01010;
273:note=5'b01100;
274:note=5'b01100;
275:note=5'b01010;
276:note=5'b01100;
277:note=5'b01101;
278:note=5'b01000;
279:note=5'b01100;
280:note=5'b01000;
281:note=5'b01101;
282:note=5'b01000;
283:note=5'b01111;
284:note=5'b01000;
285:note=5'b01100;
286:note=5'b01000;
287:note=5'b01011;
288:note=5'b01000;
289:note=5'b01010;
290:note=5'b01010;
291:note=5'b01010;
292:note=5'b01100;
293:note=5'b01011;
294:note=5'b01011;
295:note=5'b10010;
296:note=5'b10001;
297:note=5'b10000;
298:note=5'b01111;
299:note=5'b01110;
300:note=5'b01110;
301:note=5'b10001;
302:note=5'b10000;
303:note=5'b10001;
304:note=5'b10010;
305:note=5'b10001;
306:note=5'b10000;
307:note=5'b01111;
308:note=5'b01110;
309:note=5'b01101;
310:note=5'b01101;
311:note=5'b10001;
312:note=5'b10001;
313:note=5'b01100;
314:note=5'b01100;
315:note=5'b10001;
316:note=5'b10001;
317:note=5'b01101;
318:note=5'b01101;
319:note=5'b01101;
320:note=5'b01101;
321:note=5'b01101;
322:note=5'b01101;
323:note=5'b01101;
324:note=5'b01101;
325:note=5'b01101;
326:note=5'b01111;
327:note=5'b10001;
328:note=5'b00000;
329:note=5'b00000;
330:note=5'b01101;
331:note=5'b01111;
332:note=5'b10001;
333:note=5'b10000;
334:note=5'b10000;
335:note=5'b10000;
336:note=5'b10000;
337:note=5'b10011;
338:note=5'b10011;
339:note=5'b10011;
340:note=5'b10011;
341:note=5'b10000;
342:note=5'b10000;
343:note=5'b10000;
344:note=5'b10101;
345:note=5'b10100;
346:note=5'b10100;
347:note=5'b10100;
348:note=5'b10011;
349:note=5'b10100;
350:note=5'b10100;
351:note=5'b10100;
352:note=5'b10100;
353:note=5'b11000;
354:note=5'b11000;
355:note=5'b11000;
356:note=5'b11000;

    default:note=0;
    endcase
end

always@(*)begin
    if(return) get_return<=1;
    else get_return<=0;
end


get_notes   U1(clk,clk_spec,note,buzzer);

endmodule