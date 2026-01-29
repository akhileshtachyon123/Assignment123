import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import MATH_CHANNEL from '@salesforce/messageChannel/mathOperationChannel__c';

export default class PublisherComponent extends LightningElement {

    inputValue = 0;

    @wire(MessageContext)
    messageContext;

    handleChange(event) {
        this.inputValue = Number(event.target.value);
    }

    publishMessage(operation) {
        const message = {
            operation: operation,
            value: this.inputValue
        };

        publish(this.messageContext, MATH_CHANNEL, message);
    }

    handleAdd() {
        this.publishMessage('ADD');
    }

    handleSubtract() {
        this.publishMessage('SUBTRACT');
    }

    handleMultiply() {
        this.publishMessage('MULTIPLY');
    }
}