import { LightningElement,wire } from 'lwc';
import {publish, MessageContext} from 'lightning/messageService';
import BUTTON_CHANNEL from '@salesforce/messageChannel/buttonMessageChannel__c';

export default class Publisher extends LightningElement 
{
   @wire(MessageContext)
   messageContext;

   handleClick()
   {
    const payload={message: 'Hello from Publisher'};
    publish(this.messageContext,BUTTON_CHANNEL,payload);
   }
}