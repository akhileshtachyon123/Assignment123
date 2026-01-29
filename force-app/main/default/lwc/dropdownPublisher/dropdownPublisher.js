import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import DROPDOWN_CHANNEL from '@salesforce/messageChannel/DropdownMessageChannel__c';


export default class DropdownPublisher extends LightningElement {
    value = '';

    options = [
        { label: 'New', value: 'New' },
        { label: 'Working', value: 'Working' },
        { label: 'Closed', value: 'Closed' }
    ];

    @wire(MessageContext)
    messageContext;

    handleChange(event) {
        this.value = event.detail.value;

        publish(this.messageContext, DROPDOWN_CHANNEL, {
            status: this.value
        });
    }
}