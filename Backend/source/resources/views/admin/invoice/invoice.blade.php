
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Invoice</title>
        <style>
 html {
    width: 180px;
}
  * {
    font-size: 12px;
    font-family: 'Times New Roman';
}

td,
th,
tr,
table {
    border-top: 1px solid black;
    border-collapse: collapse;
}

td.description,
th.description {
    width: 65px;
    max-width: 65px;
}

td.quantity,
th.quantity {
    width: 30px;
    max-width: 30px;
    word-break: break-all;
}

td.price,
th.price {
    width: 40px;
    max-width: 40px;
    word-break: break-all;
}

.centered {
    text-align: center;
    align-content: center;
}



img {
    max-width: inherit;
    width: inherit;
}

@media print {
    .hidden-print,
    .hidden-print * {
        display: none !important;
    }
}  </style>
    </head>
    <body>
        <div class="ticket" align="center">
              <img src="{{url($logo->icon)}}" alt="app-logo" style="width:40px"/>
             <table id="datatables" class="table table-striped table-no-bordered table-hover" cellspacing="0" width="100%" style="width:100%" data-background-color="purple">

                
                <tbody>
                    <tr>
                        <td colspan="5">
                            <table class="table">
                                <tr>
                                    <td valign="top" style="width:50%">
                                    <strong> {{ __('keywords.Order_Id')}} : </strong> {{$order->cart_id}}
                                    <br />
                                      <strong>{{ __('keywords.Customer_name')}} : </strong>{{$order->receiver_name}}<br/>
                                        <strong>{{ __('keywords.Contact')}} : </strong>{{$order->receiver_phone}}, @if($order->user_phone != $order->receiver_phone){{$order->receiver_phone}}@endif <br/> 
                                    <strong>  {{ __('keywords.Delivery_Date')}} : </strong>{{$order->delivery_date}}
                                    <br />
                                    <strong>  {{ __('keywords.Time_Slot')}} : </strong>{{$order->time_slot}}
                                    <br />
                                    </td>
                                    <td  style="width:50%" align="right">
                                        <strong> {{ __('keywords.Delivery Address')}} </strong><br />
                                      
                                        <b>{{$order->type}} :</b> {{$order->house_no}},{{$order->society}},<br>@if($order->landmark !=NULL) {{$order->landmark}},<br>@endif {{$order->city}},{{$order->state}},<br>
                                          {{$order->pincode}}
                                     </td>
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>

                    <tr>
                        <th>{{ __('keywords.Product_Name')}}</th>
                        <th>{{ __('keywords.Qty')}}</th>
                        <th>{{ __('keywords.Tax')}}</th>
                        <th>{{ __('keywords.Price')}}</th>
                        <th>{{ __('keywords.Total_Price')}}</th>
                    </tr>
                    @if(count($details)>0)
                            @php $i=1; @endphp
                                      
                          <tr>             
                        @foreach($details as $detailss)
                        
                         <td><p>{{$detailss->product_name}}({{$detailss->quantity}}{{$detailss->unit}})</p>
                            </td>
                            <td>{{$detailss->qty}}</td>
                             <td> @if($detailss->tx_per == 0 || $detailss->tx_per == NULL)0 @else {{$detailss->tx_per}}@endif % @if($detailss->tx_per != 0 && $detailss->tx_name != NULL)({{$detailss->tx_name}})@endif</td>
                             <td>
                            <p><span style="color:grey">@if($detailss->price_without_tax != NULL){{$detailss->price_without_tax}} @else {{$detailss->price}} @endif</span></p>
                           </td>
                            <td> 
                            <p><span style="color:grey">{{$detailss->price}}</span></p>
                           </td>
    		          
                         </tr>
                            @php $i++; @endphp
                            @endforeach
                          @else
                            <tr>
                              <td>{{ __('keywords.No_data_found')}}</td>
                            </tr>
                                  @endif
                   
                   
                    <tr>
                        <td colspan="4" class="text-right"><strong class="pull-right">{{ __('keywords.Products_Price')}} : </strong></td>
                         <td  class="text-right" colspan="1">
                            <strong>{{$order->price_without_delivery}}</strong>
                        </td>
                    </tr><tr>
                        <td colspan="4"  class="text-right"><strong class="pull-right">{{ __('keywords.Delivery_Charge')}} : </strong></td>
                         <td  class="text-right"  colspan="1">
                            <strong >+{{$order->delivery_charge}}</strong>
                        </td>
                    </tr>@if($order->paid_by_wallet > 0)
                    <tr>    
                        <td colspan="4"  class="text-right"><strong class="pull-right">{{ __('keywords.Paid_By_Wallet')}} : </strong></td>
                         <td  class="text-right" colspan="1">
                            <strong>-{{$order->paid_by_wallet}}</strong>
                        </td>
                    </tr>@endif
                    @if($order->coupon_discount > 0)
                    <tr>    
                        <td colspan="4" class="text-right"><strong class="pull-right">{{ __('keywords.Coupon_Discount')}} : </strong></td>
                         <td  class="text-right" colspan="1">
                            <strong class="">-{{$order->coupon_discount}}</strong>
                        </td>
                    </tr>
                    @endif
                    <tr>
                        <td colspan="4" class="text-right"><strong class="pull-right">{{ __('keywords.Net_Total(Payable)')}}:</strong></td>
                        <td  class="text-right" colspan="1">{{$order->rem_price}}</td>
                    </tr>
                </tbody>
            </table>
            <p class="centered">Thanks for your purchase!
        </div>
        <button id="btnPrint" class="hidden-print">Print</button>
        <script>const $btnPrint = document.querySelector("#btnPrint");
$btnPrint.addEventListener("click", () => {
    window.print();
});</script>
    </body>
</html>