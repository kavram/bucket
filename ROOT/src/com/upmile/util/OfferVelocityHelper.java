package com.upmile.util;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map.Entry;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONObject;

import com.upmile.data.IObject;
import com.upmile.data.PaddedPipeSeparatedStr;

public class OfferVelocityHelper {
	static Logger log = Logger.getLogger(OfferVelocityHelper.class);
	
	private IObject offer;
	private IObject order;
	private Collection<IObject> orders;
	private String pickupDatesType;
	private Collection<JSONObject> pickupWDays;
	private Collection<JSONObject> items;
	private float offerDiscount;
	private float orderTotalPrice = 0;
	private DecimalFormat decf = new DecimalFormat("###.##");
	
	public OfferVelocityHelper(IObject offer) throws Exception{
		initOffer(offer);
	}
	
	public OfferVelocityHelper(IObject order, IObject offer) throws Exception{
		this.order = order;
		initOffer(offer);
		PaddedPipeSeparatedStr items = (PaddedPipeSeparatedStr) order.getINode("items").getValue();
		for(Entry<Long, Integer> entry : items.getParsedValues().entrySet()){
			orderTotalPrice += entry.getValue() * getItemPrice(entry.getKey());
		}
	}

	public OfferVelocityHelper(IObject offer, Collection<IObject> orders) throws Exception{
		initOffer(offer);
		this.orders = orders;
	}
	
	public Collection<IObject> getOfferOrders(){
		return orders;
	}
	
	public String getOfferOrdersAsJsonString() throws Exception{
		JSONArray ja = new JSONArray();
		for(IObject order : orders){
			ja.put(order.getJSONObj());
		}
		return ja.toString();
	}
	
	public String getPickupNote() throws Exception{
		if(((JSONObject)offer.getINode("pickup").getValue()).has("note"))
			return  ((JSONObject)offer.getINode("pickup").getValue()).getString("note");
		else
			return "";
	}
	
	public String getPickupName() throws Exception{
		if(((JSONObject)offer.getINode("pickup").getValue()).has("name"))
			return  ((JSONObject)offer.getINode("pickup").getValue()).getString("name");
		else
			return "";
	}
	
	
	public String getItemOrderedNum(String itemId) throws Exception{
		for(JSONObject item : items){
			if(item.getString("id").equals(itemId))
				return item.getString("ordered");
		}
		return "";
	}
	
	public JSONObject getItem(String itemId) throws Exception{
		for(JSONObject item : items){
			if(item.getString("id").equals(itemId))
				return item;
		}
		return null;
	}
	
	private float getOrderTotalPrice(){
		return orderTotalPrice;
	}
	
	private float getItemPrice(Long itemId) throws Exception {
		for(JSONObject item : items){
			if(item.getString("id").equals(itemId.toString())){
				 return Float.parseFloat(item.getString("price"));
			}
		}
		return 0;
	}
	
	private void initOffer(IObject offer) throws Exception {
		this.offer = offer;
		log.debug("pickup: " + ((JSONObject)offer.getINode("pickup").getValue()).toString());
		pickupDatesType = ((JSONObject)offer.getINode("pickup").getValue()).getJSONObject("dates").getString("type");
		if(pickupDatesType.equals("wd")){
			pickupWDays = new ArrayList<JSONObject>();
			JSONArray days = ((JSONObject)offer.getINode("pickup").getValue()).getJSONObject("dates").getJSONArray("dates");
			for(int i = 0; i < days.length(); i++)
				pickupWDays.add(days.getJSONObject(i));
		}
		JSONArray offerItems = (JSONArray)offer.getINode("items").getValue();
		items = new ArrayList<JSONObject>();
		for(int i = 0; i < offerItems.length(); i++){
			JSONObject item = offerItems.getJSONObject(i);
			if(offer.getINode("items_ordered") != null){
				item.accumulate("ordered", ((PaddedPipeSeparatedStr)offer.getINode("items_ordered").getValue()).getParsedValue((long)item.getInt("id")));
				item.accumulate("lft", item.getInt("total") - ((PaddedPipeSeparatedStr)offer.getINode("items_ordered").getValue()).getParsedValue((long)item.getInt("id")));
			}else{
				item.accumulate("ordered", "0");
				item.accumulate("lft", item.getInt("total"));
			}
			items.add(item);
		}
		offerDiscount = initOfferDiscount();
	}
	
	private float initOfferDiscount() throws Exception {
		double dis = 0;
		JSONObject ds = new JSONObject(offer.getINode("discounts").getValue().toString());
		Double total = Double.valueOf(offer.getINode("total").getValue().toString());
		double totalOrdered = Double.valueOf(offer.getINode("total_ordered").getValue().toString());
		double qr =  total / 4;
		double iQr = Math.round(qr);
		if(totalOrdered <= iQr){
			dis = ds.getDouble("d0") + (totalOrdered * (ds.getDouble("d25") - ds.getDouble("d0"))/iQr);
		}else if(totalOrdered > iQr && totalOrdered <= iQr * 2){
			dis = ds.getDouble("d25") + ((totalOrdered - iQr)*(ds.getDouble("d50") - ds.getDouble("d25"))/(iQr));
		}else if(totalOrdered > iQr * 2 && totalOrdered <= iQr * 3){
			dis = ds.getDouble("d50") + ((totalOrdered - iQr * 2) * (ds.getDouble("d75") - ds.getDouble("d50"))/(iQr * 3 - iQr * 2));
		}else if(totalOrdered > iQr * 3 && totalOrdered <= iQr * 100){
			dis = ds.getDouble("d75") + ((totalOrdered - iQr * 3)*(ds.getDouble("d100") - ds.getDouble("d75"))/(iQr * 4 - iQr * 3));
		}
		Double fDis = new Double(dis);
		return fDis.floatValue();
	}
	
	public String getOfferDiscount(){
		//DecimalFormat decf = new DecimalFormat("###.#");
		return decf.format(offerDiscount);
	}
	
	public IObject getOrder(){
		return order;
	}
	
	public Collection<String> getOrderItemIds() throws Exception{
		Collection<String> ids = new ArrayList<String>();
		PaddedPipeSeparatedStr items = (PaddedPipeSeparatedStr) order.getINode("items").getValue();
		for(Long id : items.getParsedValues().keySet())
			ids.add(id.toString());
		return ids;
	}
	
	public String getOrderGrandTotalPrice(){
		//DecimalFormat decf = new DecimalFormat("###.#");
		float orderGrandTPrice =  orderTotalPrice * (100 - offerDiscount)/100;
		//decf.applyPattern("#.##");
		String ret = decf.format(orderGrandTPrice); 
		return ret;
	}
	
	public String getOrderItemQty(String itemId) throws Exception{
		PaddedPipeSeparatedStr items = (PaddedPipeSeparatedStr) order.getINode("items").getValue();
		Integer ret = items.getParsedValue(new Long(itemId));
		return ret == null ? "0" : ret.toString();
	}

	public String calcItemTotalPrice(String qty, String price){
		Integer iQty = Integer.valueOf(qty);
		float fPrice = Float.parseFloat(price);
		float total = iQty * fPrice;
		Float fTotal = new Float(total);
		return decf.format(fTotal);
	}
	
	public IObject getOffer(){
		return offer;
	}
	
	public String getPickupDatesType() throws  Exception{
		return pickupDatesType;
	}

	public String getFixedDatesPickup() throws Exception {
		if(!pickupDatesType.equals("fd"))
			return "";
		return ((JSONObject)offer.getINode("pickup").getValue()).getJSONObject("dates").getString("ft");
	}
	
	public Collection<JSONObject> getPickupWDays(){
		return pickupWDays;
	}
	
	public Collection<JSONObject> getItems(){
		return items;
	}
	
}
